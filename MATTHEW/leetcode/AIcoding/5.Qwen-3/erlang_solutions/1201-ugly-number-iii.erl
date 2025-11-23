-module(ugly_number_iii).
-export([nth_ugly_number/2]).

nth_ugly_number(N, A) ->
    nth_ugly_number(N, A, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1).

nth_ugly_number(N, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18) ->
    case N of
        1 -> 1;
        _ ->
            Min = min(X1, min(X2, min(X3, min(X4, min(X5, min(X6, min(X7, min(X8, min(X9, min(X10, min(X11, min(X12, min(X13, min(X14, min(X15, min(X16, min(X17, X18)))))))))))))))),
            if
                Min == X1 -> nth_ugly_number(N-1, A, A, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X2 -> nth_ugly_number(N-1, A, X1, A, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X3 -> nth_ugly_number(N-1, A, X1, X2, A, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X4 -> nth_ugly_number(N-1, A, X1, X2, X3, A, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X5 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, A, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X6 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, A, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X7 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, A, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X8 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, A, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X9 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, A, X10, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X10 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, A, X11, X12, X13, X14, X15, X16, X17, X18);
                Min == X11 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, A, X12, X13, X14, X15, X16, X17, X18);
                Min == X12 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, A, X13, X14, X15, X16, X17, X18);
                Min == X13 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, A, X14, X15, X16, X17, X18);
                Min == X14 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, A, X15, X16, X17, X18);
                Min == X15 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, A, X16, X17, X18);
                Min == X16 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, A, X17, X18);
                Min == X17 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, A, X18);
                Min == X18 -> nth_ugly_number(N-1, A, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, A)
            end.