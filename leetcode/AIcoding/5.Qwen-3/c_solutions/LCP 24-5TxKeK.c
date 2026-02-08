#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getHappyString(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int count = 0;
    char chars[] = {'a', 'b', 'c'};

    void backtrack(int index, char* current) {
        if (index == n) {
            count++;
            if (count == k) {
                strcpy(result, current);
            }
            return;
        }
        for (int i = 0; i < 3; i++) {
            if (index == 0 || current[index - 1] != chars[i]) {
                current[index] = chars[i];
                backtrack(index + 1, current);
                if (count == k) return;
            }
        }
    }

    char* temp = (char*)malloc((n + 1) * sizeof(char));
    backtrack(0, temp);
    free(temp);
    return count >= k ? result : NULL;
}