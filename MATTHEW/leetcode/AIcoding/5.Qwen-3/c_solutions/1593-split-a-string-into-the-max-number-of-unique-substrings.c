#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxUniqueSplit(char* s) {
    int n = strlen(s);
    int maxCount = 0;
    char* set = (char*)malloc(n * sizeof(char));
    int setLen = 0;

    void backtrack(int start, int count) {
        if (start == n) {
            maxCount = (count > maxCount) ? count : maxCount;
            return;
        }
        for (int i = start + 1; i <= n; i++) {
            char* substr = (char*)malloc((i - start + 1) * sizeof(char));
            strncpy(substr, s + start, i - start);
            substr[i - start] = '\0';
            int unique = 1;
            for (int j = 0; j < setLen; j++) {
                if (strcmp(substr, set + j * (i - start)) == 0) {
                    unique = 0;
                    break;
                }
            }
            if (unique) {
                strcpy(set + setLen * (i - start), substr);
                setLen++;
                backtrack(i, count + 1);
                setLen--;
            }
            free(substr);
        }
    }

    backtrack(0, 0);
    free(set);
    return maxCount;
}