-module(longest_turbulent_subarray).
-export([maxTurbulenceSize/1]).

maxTurbulenceSize(A) ->
    maxTurbulenceSize(A, 0, 0, 0, length(A)).

maxTurbulenceSize(_A, L, R, Max, N) when R >= N ->
    max(Max, R - L);

maxTurbulenceSize(A, L, R, Max, N) ->
    case R > L of
        true ->
            case isTurbulent(A, R - 1, R) of
                true ->
                    maxTurbulenceSize(A, L, R + 1, Max, N);
                false ->
                    maxTurbulenceSize(A, R, R, max(Max, R - L), N)
            end;
        false ->
            maxTurbulenceSize(A, L, R + 1, Max, N)
    end.

isTurbulent(A, I, J) ->
    case element(I + 1, A) =/= element(J + 1, A) of
        true ->
            true;
        false ->
            false
    end.

maxTurbulenceSize(A, L, R, Max, N) ->
    case R > L of
        true ->
            case isTurbulent(A, R - 1, R) of
                true ->
                    maxTurbulenceSize(A, L, R + 1, Max, N);
                false ->
                    maxTurbulenceSize(A, R, R, max(Max, R - L), N)
            end;
        false ->
            maxTurbulenceSize(A, L, R + 1, Max, N)
    end.

isTurbulent(A, I, J) ->
    case I < 0 or J >= length(A) of
        true ->
            false;
        false ->
            case I >= 0 and I < length(A) and J >= 0 and J < length(A) of
                true ->
                   case I > 0 of
                        true ->
                            case (element(I, A) > element(I + 1, A) and element(I - 1 + 1, A) < element(I, A)) or (element(I, A) < element(I + 1, A) and element(I - 1 + 1, A) > element(I, A)) of
                                true ->
                                    true;
                                false ->
                                    false
                            end;
                        false ->
                            true
                   end;
                false ->
                    false
            end
    end.

isTurbulent(A, I, J) ->
    case I < 0 or J >= length(A) of
        true ->
            false;
        false ->
            case I >= 0 and I < length(A) and J >= 0 and J < length(A) of
                true ->
                    case I > 0 of
                        true ->
                            case (lists:nth(I, A) > lists:nth(I + 1, A) and lists:nth(I - 1 + 1, A) < lists:nth(I, A)) or (lists:nth(I, A) < lists:nth(I + 1, A) and lists:nth(I - 1 + 1, A) > lists:nth(I, A)) of
                                true ->
                                    true;
                                false ->
                                    false
                            end;
                        false ->
                            true
                   end;
                false ->
                    false
            end
    end.

maxTurbulenceSize(A) ->
    N = length(A),
    maxTurbulenceSize(A, 0, 0, 0, N).

maxTurbulenceSize(A, L, R, Max, N) when R >= N ->
    max(Max, R - L);
maxTurbulenceSize(A, L, R, Max, N) ->
    case R > L of
        true ->
            case isTurbulent(A, R - 1, R) of
                true ->
                    maxTurbulenceSize(A, L, R + 1, Max, N);
                false ->
                    maxTurbulenceSize(A, R, R, max(Max, R - L), N)
            end;
        false ->
            maxTurbulenceSize(A, L, R + 1, Max, N)
    end.

isTurbulent(A, I, J) ->
  I_val = lists:nth(I+1, A),
  J_val = lists:nth(J+1, A),

    case I < 0 or J >= length(A) of
        true ->
            false;
        false ->
            case I >= 0 and I < length(A) and J >= 0 and J < length(A) of
                true ->
                    case I > 0 of
                        true ->
                            case (lists:nth(I, A) > lists:nth(I+1, A) and lists:nth(I-1+1, A) < lists:nth(I, A)) or (lists:nth(I, A) < lists:nth(I+1, A) and lists:nth(I-1+1, A) > lists:nth(I, A)) of

                                true ->
                                    true;
                                false ->
                                    false
                            end;
                        false ->
                            true
                   end;
                false ->
                    false
            end
    end.
maxTurbulenceSize(A) ->
  N = length(A),
  maxTurbulenceSizeHelper(A, 0, 0, 0, N).

maxTurbulenceSizeHelper(_A, L, R, Max, N) when R >= N ->
  max(Max, R - L);
maxTurbulenceSizeHelper(A, L, R, Max, N) ->
  case R > L of
    true ->
      case isTurbulent(A, R - 1) of
        true ->
          maxTurbulenceSizeHelper(A, L, R + 1, Max, N);
        false ->
          maxTurbulenceSizeHelper(A, R, R, max(Max, R - L), N)
      end;
    false ->
      maxTurbulenceSizeHelper(A, L, R + 1, Max, N)
  end.

isTurbulent(_A, _I) ->
  false.

isTurbulent(A, I) ->
  case I < 0 or I+1 >= length(A) of
    true -> false;
    false ->
      case (lists:nth(I+1, A) > lists:nth(I+2, A) and (I == 0 or lists:nth(I, A) < lists:nth(I+1, A))) or
           (lists:nth(I+1, A) < lists:nth(I+2, A) and (I == 0 or lists:nth(I, A) > lists:nth(I+1, A))) of
        true -> true;
        false -> false
      end
  end.