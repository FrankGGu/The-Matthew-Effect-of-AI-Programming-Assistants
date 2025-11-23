#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isPalindrome(char *s) {
    int len = strlen(s);
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) return 0;
    }
    return 1;
}

char* convertBase(int num, int base) {
    char *result = (char*)malloc(32 * sizeof(char));
    int index = 0;
    if (num == 0) {
        result[0] = '0';
        result[1] = '\0';
        return result;
    }
    while (num > 0) {
        result[index++] = '0' + (num % base);
        num /= base;
    }
    result[index] = '\0';
    for (int i = 0; i < index / 2; i++) {
        char temp = result[i];
        result[i] = result[index - 1 - i];
        result[index - 1 - i] = temp;
    }
    return result;
}

int kMirror(int k, int n) {
    int count = 0;
    int num = 1;
    while (count < n) {
        char *baseK = convertBase(num, k);
        if (isPalindrome(baseK)) {
            count++;
            free(baseK);
            if (count == n) {
                return num;
            }
        } else {
            free(baseK);
        }
        num++;
    }
    return -1;
}