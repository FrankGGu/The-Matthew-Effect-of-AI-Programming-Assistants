-module(delete_columns_to_make_sorted_ii).
-export([min_deletion_size/1]).

min_deletion_size(strs) ->
    min_deletion_size(strs, 0, []).

min_deletion_size([], Acc, _) ->
    Acc;
min_deletion_size(Strs, Acc, SortedPrefix) ->
    Len = length(hd(Strs)),
    min_deletion_size(Strs, Acc, SortedPrefix, 0, Len).

min_deletion_size(Strs, Acc, SortedPrefix, Col, Len) when Col >= Len ->
    Acc;
min_deletion_size(Strs, Acc, SortedPrefix, Col, Len) ->
    case is_deletable(Strs, SortedPrefix, Col) of
        true ->
            min_deletion_size(Strs, Acc + 1, SortedPrefix, Col + 1, Len);
        false ->
            NewSortedPrefix = get_sorted_prefix(Strs, SortedPrefix, Col),
            min_deletion_size(Strs, Acc, NewSortedPrefix, Col + 1, Len)
    end.

is_deletable(Strs, SortedPrefix, Col) ->
    is_deletable(Strs, SortedPrefix, Col, []).

is_deletable([], _, _, _) ->
    true;
is_deletable([Str | Rest], SortedPrefix, Col, Acc) ->
    case SortedPrefix of
        [] ->
            case Acc of
                [] ->
                    is_deletable(Rest, SortedPrefix, Col, [Str]);
                [Prev | _] ->
                    if
                        Str:string(Col + 1, 1) >= Prev:string(Col + 1, 1) ->
                            is_deletable(Rest, SortedPrefix, Col, [Str | Acc]);
                        true ->
                            false
                    end
            end;
        Prefix ->
            case Acc of
                [] ->
                    case lists:member(Str, Prefix) of
                        true ->
                            is_deletable(Rest, SortedPrefix, Col, [Str]);
                        false ->
                            case lists:member(hd(Prefix), [Str]) of
                                true ->
                                    is_deletable(Rest, SortedPrefix, Col, [Str]);
                                false ->
                                    is_deletable(Rest, SortedPrefix, Col, [Str])
                            end
                    end;
                [Prev | _] ->
                  case lists:member(Str, Prefix) of
                      true ->
                          is_deletable(Rest, SortedPrefix, Col, [Str | Acc]);
                      false ->
                          case lists:member(hd(Prefix), [Str]) of
                              true ->
                                  is_deletable(Rest, SortedPrefix, Col, [Str | Acc]);
                              false ->
                                  if
                                      Str:string(Col + 1, 1) >= Prev:string(Col + 1, 1) ->
                                          is_deletable(Rest, SortedPrefix, Col, [Str | Acc]);
                                      true ->
                                          false
                                  end
                          end
                  end
            end
    end.

get_sorted_prefix(Strs, SortedPrefix, Col) ->
    get_sorted_prefix(Strs, SortedPrefix, Col, []).

get_sorted_prefix([], _, _, Acc) ->
    lists:reverse(Acc);
get_sorted_prefix([Str | Rest], SortedPrefix, Col, Acc) ->
    case SortedPrefix of
        [] ->
            case Acc of
                [] ->
                    get_sorted_prefix(Rest, SortedPrefix, Col, [Str]);
                [Prev | _] ->
                    if
                        Str:string(Col + 1, 1) == Prev:string(Col + 1, 1) ->
                            get_sorted_prefix(Rest, SortedPrefix, Col, [Str | Acc]);
                        true ->
                            get_sorted_prefix(Rest, SortedPrefix, Col, Acc)
                    end
            end;
        Prefix ->
            case Acc of
                [] ->
                    case lists:member(Str, Prefix) of
                        true ->
                            get_sorted_prefix(Rest, SortedPrefix, Col, [Str]);
                        false ->
                            get_sorted_prefix(Rest, SortedPrefix, Col, Acc)
                    end;
                [Prev | _] ->
                    case lists:member(Str, Prefix) of
                        true ->
                            if
                                Str:string(Col + 1, 1) == Prev:string(Col + 1, 1) ->
                                    get_sorted_prefix(Rest, SortedPrefix, Col, [Str | Acc]);
                                true ->
                                    get_sorted_prefix(Rest, SortedPrefix, Col, Acc)
                            end;
                        false ->
                            get_sorted_prefix(Rest, SortedPrefix, Col, Acc)
                    end
            end
    end.