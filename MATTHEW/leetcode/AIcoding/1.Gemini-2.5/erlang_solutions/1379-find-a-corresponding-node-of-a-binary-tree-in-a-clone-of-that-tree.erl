-module(solution).
-export([get_target_copy/3]).

get_target_copy(Original, Cloned, Target) ->
    case Original of
        null ->
            null;
        Target ->
            Cloned;
        {_OriginalVal, LeftOriginal, RightOriginal} ->
            {_ClonedVal, LeftCloned, RightCloned} = Cloned,
            ResultLeft = get_target_copy(LeftOriginal, LeftCloned, Target),
            case ResultLeft of
                null ->
                    get_target_copy(RightOriginal, RightCloned, Target);
                _ ->
                    ResultLeft
            end
    end.