#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strongPasswordChecker(char* password) {
    int n = strlen(password);
    int missingType = 3;
    if (strpbrk(password, "0123456789")) missingType--;
    if (strpbrk(password, "abcdefghijklmnopqrstuvwxyz")) missingType--;
    if (strpbrk(password, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")) missingType--;

    if (n < 6) {
        return (6 - n) > missingType ? (6 - n) : missingType;
    } else if (n <= 20) {
        int replace = 0;
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && password[j] == password[i]) j++;
            int length = j - i;
            if (length >= 3) replace += length / 3;
            i = j;
        }
        return (replace > missingType) ? replace : missingType;
    } else {
        int replace = 0;
        int[] repeat = (int*)malloc(sizeof(int) * n);
        int k = 0;
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && password[j] == password[i]) j++;
            int length = j - i;
            if (length >= 3) {
                repeat[k++] = length;
            }
            i = j;
        }

        int removeCount = n - 20;
        for (int i = 0; i < k && removeCount > 0; i++) {
            if (repeat[i] % 3 == 0) {
                int use = (removeCount >= 1) ? 1 : 0;
                repeat[i] -= use;
                removeCount -= use;
            }
        }

        for (int i = 0; i < k && removeCount > 0; i++) {
            if (repeat[i] % 3 == 1 && removeCount >= 2) {
                int use = 2;
                repeat[i] -= use;
                removeCount -= use;
            }
        }

        for (int i = 0; i < k && removeCount > 0; i++) {
            int use = (repeat[i] - 2) / 3;
            use = (use > 0) ? use : 0;
            use = (use < removeCount) ? use : removeCount;
            repeat[i] -= use;
            removeCount -= use;
        }

        for (int i = 0; i < k; i++) {
            if (repeat[i] >= 3) {
                replace += repeat[i] / 3;
            }
        }

        free(repeat);
        return (replace > missingType) ? replace : missingType + (n - 20);
    }
}