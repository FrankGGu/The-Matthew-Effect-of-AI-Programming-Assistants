#include <stdlib.h>
#include <string.h>

int* maxDepthAfterSplit(char* s, int* returnSize) {
    int n = strlen(s);
    int* answer = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int depth = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            answer[i] = depth % 2;
            depth++;
        } else { // s[i] == ')'
            depth--;
            answer[i] = depth % 2;
        }
    }

    return answer;
}