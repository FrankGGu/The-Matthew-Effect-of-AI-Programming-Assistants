#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **result;
int resultSize;
int *returnSize;
char *num;
int target;
int n;
char *path;

void dfs(int pos, long long curRes, long long preNum, int pathLen) {
    if (pos == n) {
        if (curRes == target) {
            result[resultSize] = (char *)malloc((pathLen + 1) * sizeof(char));
            strcpy(result[resultSize], path);
            resultSize++;
        }
        return;
    }

    for (int i = pos; i < n; i++) {
        if (i > pos && num[pos] == '0') {
            break;
        }
        long long curNum = 0;
        for (int j = pos; j <= i; j++) {
            curNum = curNum * 10 + (num[j] - '0');
        }

        if (pos == 0) {
            sprintf(path, "%lld", curNum);
            dfs(i + 1, curNum, curNum, i - pos + 1);
            path[0] = '\0';
        } else {
            path[pathLen] = '+';
            sprintf(path + pathLen + 1, "%lld", curNum);
            dfs(i + 1, curRes + curNum, curNum, pathLen + 1 + (i - pos + 1));
            path[pathLen] = '\0';

            path[pathLen] = '-';
            sprintf(path + pathLen + 1, "%lld", curNum);
            dfs(i + 1, curRes - curNum, -curNum, pathLen + 1 + (i - pos + 1));
            path[pathLen] = '\0';

            path[pathLen] = '*';
            sprintf(path + pathLen + 1, "%lld", curNum);
            dfs(i + 1, curRes - preNum + preNum * curNum, preNum * curNum, pathLen + 1 + (i - pos + 1));
            path[pathLen] = '\0';
        }
    }
}

char **addOperators(char *_num, int _target, int *_returnSize) {
    num = _num;
    target = _target;
    n = strlen(num);
    result = (char **)malloc(10000 * sizeof(char *));
    resultSize = 0;
    path = (char *)malloc((2 * n) * sizeof(char));
    path[0] = '\0';
    dfs(0, 0, 0, 0);
    *returnSize = resultSize;
    return result;
}