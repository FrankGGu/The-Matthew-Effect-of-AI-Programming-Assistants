-module(accounts_merge).
-export([accounts_merge/1]).

accounts_merge(Accounts) ->
  {EmailToIndex, IndexToEmail} = build_email_maps(Accounts),
  {NumEmails, _} = maps:size(EmailToIndex),
  UF = uf_create(NumEmails),

  lists:foreach(
    fun(Account) ->
      Emails = tl(Account),
      FirstEmail = hd(Emails),
      FirstIndex = maps:get(FirstEmail, EmailToIndex),
      lists:foreach(
        fun(Email) ->
          Index = maps:get(Email, EmailToIndex),
          uf_union(UF, FirstIndex, Index)
        end,
        tl(Emails)
      )
    end,
    Accounts
  ),

  EmailGroups = group_emails(UF, IndexToEmail),

  lists:map(
    fun({Email, Emails}) ->
      lists:sort([Email | lists:sort(Emails)])
    end,
    maps:to_list(EmailGroups)
  ).

build_email_maps(Accounts) ->
  {EmailToIndex, IndexToEmail, _} = lists:foldl(
    fun(Account, {EmailToIndexAcc, IndexToEmailAcc, Index}) ->
      lists:foldl(
        fun(Email, {EmailToIndexAcc2, IndexToEmailAcc2, Index2}) ->
          case maps:is_key(Email, EmailToIndexAcc2) of
            true ->
              {EmailToIndexAcc2, IndexToEmailAcc2, Index2};
            false ->
              {maps:put(Email, Index2, EmailToIndexAcc2),
               maps:put(Index2, Email, IndexToEmailAcc2),
               Index2 + 1}
          end
        end,
        {EmailToIndexAcc, IndexToEmailAcc, Index},
        tl(Account)
      )
    end,
    {#{}, #{}, 0},
    Accounts
  ),
  {EmailToIndex, IndexToEmail}.

group_emails(UF, IndexToEmail) ->
  lists:foldl(
    fun(Index, Acc) ->
      Root = uf_find(UF, Index),
      Email = maps:get(Index, IndexToEmail),
      case maps:is_key(Root, Acc) of
        true ->
          maps:update_with(Root, fun(Emails) -> [Email | Emails] end, [], Acc);
        false ->
          maps:put(Root, [Email], Acc)
      end
    end,
    #{},
    lists:seq(0, maps:size(IndexToEmail) - 1)
  ).

-record(uf, {parent, rank}).

uf_create(N) ->
  UF = [ #uf{parent = I, rank = 0} || I <- lists:seq(0, N - 1)],
  UF.

uf_find(UF, I) ->
  case UF[I+1]#uf.parent =:= I of
    true ->
      I;
    false ->
      Root = uf_find(UF, UF[I+1]#uf.parent),
      UF2 = UF#uf{parent = Root},
      lists:nth(I+1, UF2),
      Root
  end.

uf_union(UF, I, J) ->
  RootI = uf_find(UF, I),
  RootJ = uf_find(UF, J),
  case RootI =:= RootJ of
    true ->
      UF;
    false ->
      RankI = UF[RootI+1]#uf.rank,
      RankJ = UF[RootJ+1]#uf.rank,
      case RankI < RankJ of
        true ->
          UF2 = UF#uf{parent = RootJ},
          lists:nth(RootI+1, UF2),
          UF2;
        false ->
          case RankI > RankJ of
            true ->
              UF2 = UF#uf{parent = RootI},
              lists:nth(RootJ+1, UF2),
              UF2;
            false ->
              UF2 = UF#uf{parent = RootI, rank = RankI + 1},
              lists:nth(RootJ+1, UF2),
              UF3 = UF#uf{parent = RootI},
              lists:nth(RootJ+1, UF3),
              UF3
          end
      end
  end.