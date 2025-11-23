-module(find_substring).
-export([find_substring/4]).

find_substring(S, Power, Module, K) ->
    Len = length(S),
    InitialHash = calculate_initial_hash(S, Power, Module, K),

    case check_initial_hash(InitialHash, Module) of
        true ->
            list_to_binary(lists:sublist(binary_to_list(S), 1, K));
        false ->
            find_substring_helper(S, Power, Module, K, InitialHash, 1, Len - K + 1)
    end.

find_substring_helper(S, Power, Module, K, PrevHash, Start, End) ->
    if Start > End then
        <<>>
    else
        NewHash = update_hash(S, Power, Module, K, PrevHash, Start - 1);
        case check_new_hash(NewHash, Module) of
            true ->
                list_to_binary(lists:sublist(binary_to_list(S), Start, K));
            false ->
                find_substring_helper(S, Power, Module, K, NewHash, Start + 1, End)
        end
    end.

calculate_initial_hash(S, Power, Module, K) ->
    calculate_hash(S, Power, Module, K, 0, 1).

calculate_hash(S, Power, Module, K, Acc, Index) ->
    case K < 1 of
        true ->
            Acc;
        false ->
            Char = list_to_integer([lists:nth(Index, binary_to_list(S))]);
            calculate_hash(S, Power, Module, K - 1, (Acc + (Char * math:pow(Power, K - 1))) rem Module, Index + 1)
    end.

update_hash(S, Power, Module, K, PrevHash, StartIndex) ->
    OldChar = list_to_integer([lists:nth(StartIndex + 1, binary_to_list(S))]);
    NewChar = list_to_integer([lists:nth(StartIndex + K + 1, binary_to_list(S))]);

    H = PrevHash - (OldChar rem Module);
    H2 = (H * Power) rem Module;
    H3 = (H2 + NewChar * math:pow(Power, 0)) rem Module;

    H3 rem Module.

check_initial_hash(Hash, Module) ->
    Hash rem Module == 0.

check_new_hash(Hash, Module) ->
    Hash rem Module == 0.