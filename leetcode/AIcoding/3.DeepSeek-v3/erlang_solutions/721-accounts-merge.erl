-module(accounts_merge).
-export([accounts_merge/1]).

accounts_merge(Accounts) ->
    EmailToIndex = maps:new(),
    EmailToName = maps:new(),
    {EmailToIndex1, EmailToName1, Index} = 
        lists:foldl(fun([Name | Emails], {EToI, EToN, Idx}) ->
            lists:foldl(fun(Email, {EToIAcc, EToNAcc, IdxAcc}) ->
                case maps:is_key(Email, EToIAcc) of
                    true -> {EToIAcc, EToNAcc, IdxAcc};
                    false -> 
                        {maps:put(Email, IdxAcc, EToIAcc), 
                         maps:put(Email, Name, EToNAcc), 
                         IdxAcc + 1}
                end
            end, {EToI, EToN, Idx}, Emails)
        end, {EmailToIndex, EmailToName, 0}, Accounts),
    UF = union_find:new(Index),
    lists:foreach(fun([_Name | Emails]) ->
        case Emails of
            [] -> ok;
            [First | Rest] ->
                lists:foreach(fun(Email) ->
                    union_find:union(UF, maps:get(First, EmailToIndex1), maps:get(Email, EmailToIndex1))
                end, Rest)
        end
    end, Accounts),
    IndexToEmails = maps:new(),
    IndexToEmails1 = maps:fold(fun(Email, Idx, Acc) ->
        Root = union_find:find(UF, Idx),
        Emails = maps:get(Root, Acc, []),
        maps:put(Root, [Email | Emails], Acc)
    end, IndexToEmails, EmailToIndex1),
    lists:map(fun({Root, Emails}) ->
        Name = maps:get(hd(Emails), EmailToName1),
        [Name | lists:sort(Emails)]
    end, maps:to_list(IndexToEmails1)).

-module(union_find).
-export([new/1, find/2, union/3]).

new(Size) ->
    {array:new(Size, {default, -1}), array:new(Size, {default, 0})}.

find({Parent, _Rank} = UF, X) ->
    P = array:get(X, Parent),
    if P < 0 -> X;
       true -> 
           Root = find(UF, P),
           array:set(X, Root, Parent),
           Root
    end.

union({Parent, Rank} = UF, X, Y) ->
    XRoot = find(UF, X),
    YRoot = find(UF, Y),
    if XRoot =:= YRoot -> ok;
       true ->
           XRank = array:get(XRoot, Rank),
           YRank = array:get(YRoot, Rank),
           if XRank > YRank ->
                  array:set(YRoot, XRoot, Parent);
              XRank < YRank ->
                  array:set(XRoot, YRoot, Parent);
              true ->
                  array:set(YRoot, XRoot, Parent),
                  array:set(XRoot, array:get(XRoot, Rank) + 1, Rank)
           end
    end.