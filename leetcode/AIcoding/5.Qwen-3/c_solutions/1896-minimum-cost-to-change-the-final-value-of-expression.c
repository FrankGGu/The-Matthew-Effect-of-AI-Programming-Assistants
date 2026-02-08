#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int cost;
} Pair;

int minCostToChangeFinalValue(char* expression) {
    int n = strlen(expression);
    Pair** dp = (Pair**)malloc(n * sizeof(Pair*));
    for (int i = 0; i < n; i++) {
        dp[i] = (Pair*)malloc(2 * sizeof(Pair));
    }

    for (int i = 0; i < n; i++) {
        if (expression[i] == '0' || expression[i] == '1') {
            dp[i][0].val = expression[i] - '0';
            dp[i][0].cost = 0;
            dp[i][1].val = 1 - (expression[i] - '0');
            dp[i][1].cost = 1;
        } else if (expression[i] == '&') {
            dp[i][0].val = 0;
            dp[i][0].cost = 0;
            dp[i][1].val = 1;
            dp[i][1].cost = 0;
        } else if (expression[i] == '|') {
            dp[i][0].val = 0;
            dp[i][0].cost = 0;
            dp[i][1].val = 1;
            dp[i][1].cost = 0;
        }
    }

    for (int i = 1; i < n; i++) {
        if (expression[i] == '&' || expression[i] == '|') {
            Pair left0 = dp[i - 1][0];
            Pair left1 = dp[i - 1][1];
            Pair right0 = dp[i + 1][0];
            Pair right1 = dp[i + 1][1];

            if (expression[i] == '&') {
                int val0 = left0.val & right0.val;
                int cost0 = left0.cost + right0.cost;
                if (val0 != 0) {
                    cost0 += 1;
                }

                int val1 = left1.val & right1.val;
                int cost1 = left1.cost + right1.cost;
                if (val1 != 1) {
                    cost1 += 1;
                }

                dp[i][0].val = val0;
                dp[i][0].cost = cost0;
                dp[i][1].val = val1;
                dp[i][1].cost = cost1;
            } else if (expression[i] == '|') {
                int val0 = left0.val | right0.val;
                int cost0 = left0.cost + right0.cost;
                if (val0 != 0) {
                    cost0 += 1;
                }

                int val1 = left1.val | right1.val;
                int cost1 = left1.cost + right1.cost;
                if (val1 != 1) {
                    cost1 += 1;
                }

                dp[i][0].val = val0;
                dp[i][0].cost = cost0;
                dp[i][1].val = val1;
                dp[i][1].cost = cost1;
            }
        }
    }

    int result = dp[n - 1][1].cost;
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}