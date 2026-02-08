#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* prefix;
} Solution;

Solution* solutionCreate(char* s) {
    int n = strlen(s);
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        obj->prefix[i + 1] = obj->prefix[i] + (s[i] == 'a' ? 1 : 0);
    }
    return obj;
}

bool canMakePalindromeQueries(int* prefix, int l, int r) {
    int len = r - l + 1;
    int odd = len % 2;
    int half = len / 2;
    int count = 0;
    for (int i = 0; i < 26; i++) {
        int a = prefix[r + 1] - prefix[l];
        int b = prefix[r + 1] - prefix[l];
        if (i == 0) {
            a = prefix[r + 1] - prefix[l];
        } else {
            a = prefix[r + 1] - prefix[l];
        }
        if (a % 2 != 0) {
            count++;
        }
    }
    return count <= odd;
}

bool solutionQuery(Solution* obj, char* s, int l, int r) {
    int n = strlen(s);
    int* prefix = obj->prefix;
    int len = r - l + 1;
    int odd = len % 2;
    int half = len / 2;
    int count = 0;
    for (int i = 0; i < 26; i++) {
        int a = prefix[r + 1] - prefix[l];
        int b = prefix[r + 1] - prefix[l];
        if (i == 0) {
            a = prefix[r + 1] - prefix[l];
        } else {
            a = prefix[r + 1] - prefix[l];
        }
        if (a % 2 != 0) {
            count++;
        }
    }
    return count <= odd;
}

void solutionFree(Solution* obj) {
    free(obj->prefix);
    free(obj);
}