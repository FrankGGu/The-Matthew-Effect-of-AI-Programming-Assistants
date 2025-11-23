#include <string.h>

int longestPalindrome(char* s) {
    int count[128] = {0};
    int length = strlen(s);

    for (int i = 0; i < length; i++) {
        count[s[i]]++;
    }

    int result = 0;
    int hasOdd = 0;

    for (int i = 0; i < 128; i++) {
        if (count[i] % 2 == 0) {
            result += count[i];
        } else {
            result += count[i] - 1;
            hasOdd = 1;
        }
    }

    return result + hasOdd;
}