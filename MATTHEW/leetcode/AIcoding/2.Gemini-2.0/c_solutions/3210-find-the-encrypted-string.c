#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findEncryptedString(char* s) {
    int n = strlen(s);
    if (n == 0) return strdup("");

    char* encrypted = (char*)malloc((n + 1) * sizeof(char));
    encrypted[n] = '\0';

    if (n == 1) {
        encrypted[0] = s[0];
        return encrypted;
    }

    if (n == 2) {
        if (s[0] < s[1]) {
            encrypted[0] = s[0];
            encrypted[1] = s[1];
        } else {
            encrypted[0] = s[1];
            encrypted[1] = s[0];
        }
        return encrypted;
    }

    int min_index = 0;
    for (int i = 1; i < n; i++) {
        if (s[i] < s[min_index]) {
            min_index = i;
        }
    }

    char* left = (char*)malloc((n) * sizeof(char));
    char* right = (char*)malloc((n) * sizeof(char));
    left[0] = '\0';
    right[0] = '\0';

    strncpy(left, s, min_index);
    left[min_index] = '\0';
    strncpy(right, s + min_index + 1, n - min_index - 1);
    right[n - min_index - 1] = '\0';

    char* left_encrypted = findEncryptedString(left);
    char* right_encrypted = findEncryptedString(right);

    int left_len = strlen(left_encrypted);
    int right_len = strlen(right_encrypted);

    strncpy(encrypted, left_encrypted, left_len);
    encrypted[left_len] = s[min_index];
    strncpy(encrypted + left_len + 1, right_encrypted, right_len);

    free(left);
    free(right);
    free(left_encrypted);
    free(right_encrypted);

    return encrypted;
}