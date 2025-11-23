#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int num1, int num2) {
    if (num1 == num2) {
        return 0;
    }

    char s1[20], s2[20];
    sprintf(s1, "%d", num1);
    sprintf(s2, "%d", num2);

    int n1 = strlen(s1);
    int n2 = strlen(s2);

    if (n1 != n2) {
        return -1;
    }

    int count = 0;
    for (int i = 0; i < n1; i++) {
        if (s1[i] != s2[i]) {
            count++;
        }
    }

    return count;
}