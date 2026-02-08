-module(delete_duplicate_folders).
-export([deleteDuplicateFolder/1]).

deleteDuplicateFolder(paths) ->
  Trie = build_trie(paths),
  {_, MarkedTrie} = mark_duplicates(Trie, []),
  Result = get_paths(MarkedTrie, []),
  lists:sort(Result).

build_trie(Paths) ->
  foldl(fun(Path, Trie) -> insert_path(Path, Trie) end, #{}, Paths).

insert_path([Dir | Rest], Trie) ->
  case maps:find(Dir, Trie) of
    error ->
      insert_path(Rest, #{}, Trie#{Dir => #{}});
    {ok, SubTrie} ->
      insert_path(Rest, SubTrie, Trie#{Dir => insert_path(Rest, SubTrie)})
  end;
insert_path([], Trie) ->
  Trie#{'$' => true}.

insert_path([], Trie, ParentTrie) ->
  ParentTrie.

mark_duplicates(Trie, Seen) ->
  Signature = get_signature(Trie),
  case lists:member(Signature, Seen) of
    true ->
      {true, Trie#{'#' => true}};
    false ->
      NewSeen = [Signature | Seen],
      {false, NewTrie} = foldl(
        fun({Dir, SubTrie}, {Marked, Acc}) ->
          case Dir =/= '$' of
            true ->
              {IsDuplicate, NewSubTrie} = mark_duplicates(SubTrie, NewSeen),
              case IsDuplicate of
                true ->
                  {true || Marked, Acc#{Dir => NewSubTrie#{'#' => true}}};
                false ->
                  {Marked, Acc#{Dir => NewSubTrie}}
              end;
            false ->
              {Marked, Acc}
          end
        end, {false, Trie}, maps:to_list(Trie)),
      {NewTrie has_key '#', NewTrie}
  end.

get_signature(Trie) ->
  case maps:is_key('$', Trie) of
    true ->
      "$";
    false ->
      SortedSubTries = lists:sort(
        [get_signature(SubTrie) || {Dir, SubTrie} <- maps:to_list(Trie), Dir =/= '#']
      ),
      list_to_binary([list_to_integer(binary_to_list(X)) || X <- SortedSubTries])
  end.

get_paths(Trie, Prefix) ->
  case maps:is_key('#', Trie) of
    true ->
      [];
    false ->
      case maps:is_key('$', Trie) of
        true ->
          [Prefix];
        false ->
          lists:flatten([get_paths(SubTrie, Prefix ++ [Dir]) || {Dir, SubTrie} <- maps:to_list(Trie), Dir =/= '#'])
      end
  end.

foldl(Fun, Acc, List) ->
  foldl(Fun, Acc, List, []).

foldl(Fun, Acc, [], AccList) ->
  lists:reverse(AccList);
foldl(Fun, Acc, [H|T], AccList) ->
  NewAcc = Fun(H, Acc),
  foldl(Fun, NewAcc, T, [NewAcc | AccList]).