#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestPalindrome(char * s){
    int freq[26] = {0};
    int oddCount = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            oddCount++;
        }
    }

    if (oddCount > 1) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int start = 0;
    int end = len - 1;
    int oddChar = -1;

    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            oddChar = i;
        }
        for (int j = 0; j < freq[i] / 2; j++) {
            result[start++] = 'a' + i;
            result[end--] = 'a' + i;
        }
    }

    if (oddChar != -1) {
        result[len / 2] = 'a' + oddChar;
    }

    result[len] = '\0';
    return result;
}