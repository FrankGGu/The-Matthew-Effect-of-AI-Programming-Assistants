#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestPalindrome(char * s){
    int count[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int odd_count = 0;
    int odd_index = -1;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            odd_count++;
            odd_index = i;
        }
    }

    if (odd_count > 1) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (n + 1));
    int left = 0;
    int right = n - 1;
    for (int i = 0; i < 26; i++) {
        while (count[i] > 1) {
            result[left++] = 'a' + i;
            result[right--] = 'a' + i;
            count[i] -= 2;
        }
    }

    if (odd_index != -1) {
        result[left] = 'a' + odd_index;
    }

    result[n] = '\0';
    return result;
}