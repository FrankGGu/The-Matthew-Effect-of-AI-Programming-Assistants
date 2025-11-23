#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* prefix;
    int size;
} Solution;

Solution* solutionCreate(char* s) {
    int n = strlen(s);
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u');
    }
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefix = prefix;
    obj->size = n;
    return obj;
}

int solutionQuery(Solution* obj, int left, int right) {
    return obj->prefix[right + 1] - obj->prefix[left];
}

void solutionFree(Solution* obj) {
    free(obj->prefix);
    free(obj);
}