#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(char *s1, char *s2, char *s3) {
    int n = strlen(s1);
    int operations = 0;
    for (int i = 0; i < n; i++) {
        char a = s1[i], b = s2[i], c = s3[i];
        if ((a & b) != c) {
            operations++;
        }
    }
    return operations;
}