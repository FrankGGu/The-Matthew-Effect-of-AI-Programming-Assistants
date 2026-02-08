#include <string.h>

int countSubstrings(char* s) {
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; ++i) {
        // Odd length palindromes (center at i)
        int left = i;
        int right = i;
        while (left >= 0 && right < n && s[left] == s[right]) {
            count++;
            left--;
            right++;
        }

        // Even length palindromes (center between i and i+1)
        left = i;
        right = i + 1;
        while (left >= 0 && right < n && s[left] == s[right]) {
            count++;
            left--;
            right++;
        }
    }

    return count;
}