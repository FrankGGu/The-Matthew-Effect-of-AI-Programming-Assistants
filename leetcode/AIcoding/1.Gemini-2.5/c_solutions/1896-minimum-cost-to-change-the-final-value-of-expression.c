#include <stdlib.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int* parseExpression(char* expression, int* pos);
int* parseTerm(char* expression, int* pos);
int* parseFactor(char* expression, int* pos);

int* parseFactor(char* expression, int* pos) {
    int* res = (int*)malloc(sizeof(int) * 2);
    if (expression[*pos] == '0') {
        res[0] = 0;
        res[1] = 1;
        (*pos)++;
    } else if (expression[*pos] == '1') {
        res[0] = 1;
        res[1] = 0;
        (*pos)++;
    } else if (expression[*pos] == '(') {
        (*pos)++;
        free(res);
        res = parseExpression(expression, pos);
        (*pos)++;
    }
    return res;
}

int* parseTerm(char* expression, int* pos) {
    int* res1 = parseFactor(expression, pos);

    while (expression[*pos] == '&') {
        (*pos)++;
        int* res2 = parseFactor(expression, pos);

        int new_c0, new_c1;

        int cost_keep_and_0 = MIN(res1[0] + res2[0], MIN(res1[0] + res2[1], res1[1] + res2[0]));
        int cost_change_to_or_0 = res1[0] + res2[0] + 1;
        new_c0 = MIN(cost_keep_and_0, cost_change_to_or_0);

        int cost_keep_and_1 = res1[1] + res2[1];
        int cost_change_to_or_1 = MIN(res1[0] + res2[1], MIN(res1[1] + res2[0], res1[1] + res2[1])) + 1;
        new_c1 = MIN(cost_keep_and_1, cost_change_to_or_1);

        free(res1);
        free(res2);
        res1 = (int*)malloc(sizeof(int) * 2);
        res1[0] = new_c0;
        res1[1] = new_c1;
    }
    return res1;
}

int* parseExpression(char* expression, int* pos) {
    int* res1 = parseTerm(expression, pos);

    while (expression[*pos] == '|') {
        (*pos)++;
        int* res2 = parseTerm(expression, pos);

        int new_c0, new_c1;

        int cost_keep_or_0 = res1[0] + res2[0];
        int cost_change_to_and_0 = MIN(res1[0] + res2[0], MIN(res1[0] + res2[1], res1[1] + res2[0])) + 1;
        new_c0 = MIN(cost_keep_or_0, cost_change_to_and_0);

        int cost_keep_or_1 = MIN(res1[0] + res2[1], MIN(res1[1] + res2[0], res1[1] + res2[1]));
        int cost_change_to_and_1 = res1[1] + res2[1] + 1;
        new_c1 = MIN(cost_keep_or_1, cost_change_to_and_1);

        free(res1);
        free(res2);
        res1 = (int*)malloc(sizeof(int) * 2);
        res1[0] = new_c0;
        res1[1] = new_c1;
    }
    return res1;
}

int minCostToChangeFinalValue(char* expression) {
    int pos = 0;
    int* final_costs = parseExpression(expression, &pos);
    int result = MIN(final_costs[0], final_costs[1]);
    free(final_costs);
    return result;
}