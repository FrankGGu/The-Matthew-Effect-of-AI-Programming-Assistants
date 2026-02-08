#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfUniqueChars(char* s) {
    int n = strlen(s);
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        left[i] = -1;
        right[i] = n;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i - 1; j >= 0; j--) {
            if (s[j] == s[i]) {
                left[i] = j;
                break;
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = i + 1; j < n; j++) {
            if (s[j] == s[i]) {
                right[i] = j;
                break;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        result += (i - left[i]) * (right[i] - i);
    }

    free(left);
    free(right);
    return result;
}

int countOfAtoms(char* formula) {
    int len = strlen(formula);
    int stack[1000];
    int top = -1;
    int count[1000];
    int cnt = 0;
    char name[1000];
    int name_len = 0;
    int num = 0;
    int i = 0;

    while (i < len) {
        if (formula[i] == '(') {
            stack[++top] = cnt;
            cnt = 0;
            i++;
        } else if (formula[i] == ')') {
            i++;
            int num_start = i;
            while (i < len && isdigit(formula[i])) i++;
            num = atoi(formula + num_start);
            num = num ? num : 1;
            int prev_cnt = cnt;
            cnt = stack[top--];
            for (int j = 0; j < prev_cnt; j++) {
                count[cnt + j] *= num;
            }
        } else if (isupper(formula[i])) {
            name_len = 0;
            while (i < len && islower(formula[i])) name[name_len++] = formula[i++];
            name[name_len] = '\0';
            int num_start = i;
            while (i < len && isdigit(formula[i])) i++;
            num = atoi(formula + num_start);
            num = num ? num : 1;
            int found = 0;
            for (int j = 0; j < cnt; j++) {
                if (strcmp(name, formula + stack[j]) == 0) {
                    count[j] += num;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                strcpy(formula + stack[++cnt], name);
                count[cnt] = num;
            }
        } else {
            i++;
        }
    }

    int total = 0;
    for (int i = 0; i < cnt; i++) {
        total += count[i];
    }

    return total;
}