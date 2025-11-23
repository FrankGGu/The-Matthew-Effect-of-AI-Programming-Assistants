#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val[2];
    int idx;
} Result;

Result evaluate(char* s, int* idx) {
    Result res;
    res.val[0] = 1e9;
    res.val[1] = 1e9;
    res.idx = *idx;

    Result term = { {1e9, 1e9}, *idx };
    char op = '+';

    while (res.idx < strlen(s)) {
        if (s[res.idx] == '(') {
            res.idx++;
            term = evaluate(s, &res.idx);
        } else if (s[res.idx] >= '0' && s[res.idx] <= '1') {
            term.val[0] = 0;
            term.val[1] = 0;
            term.val[s[res.idx] - '0'] = 0;
            term.val[!(s[res.idx] - '0')] = 1;
            term.idx = res.idx;
            res.idx++;
        } else if (s[res.idx] == ')') {
            res.idx++;
            break;
        } else if (s[res.idx] == '&' || s[res.idx] == '|') {
            op = s[res.idx];
            res.idx++;
            continue;
        } else {
            res.idx++;
            continue;
        }

        if (op == '+') {
            res.val[0] = term.val[0];
            res.val[1] = term.val[1];
        } else if (op == '&') {
            int temp0 = res.val[0];
            int temp1 = res.val[1];
            res.val[0] = (temp0 == 1e9 ? 1e9 : temp0 + term.val[0]);
            res.val[1] = (temp0 == 1e9 ? 1e9 : temp0 + term.val[1]);
            res.val[1] = (temp1 == 1e9 ? 1e9 : (temp1 + term.val[1] < res.val[1] ? temp1 + term.val[1] : res.val[1]));
        } else if (op == '|') {
            int temp0 = res.val[0];
            int temp1 = res.val[1];
            res.val[0] = (temp0 == 1e9 ? 1e9 : temp0 + term.val[0]);
            res.val[0] = (temp1 == 1e9 ? 1e9 : (temp1 + term.val[0] < res.val[0] ? temp1 + term.val[0] : res.val[0]));
            res.val[1] = (temp1 == 1e9 ? 1e9 : temp1 + term.val[1]);
        }
        op = '+';
    }

    *idx = res.idx;
    return res;
}

int minCostToChange(char* expression) {
    int idx = 0;
    Result res = evaluate(expression, &idx);
    return fmin(res.val[0], res.val[1]);
}