#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMovesToMakePalindrome(char* s) {
    int n = strlen(s);
    int* count = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int res = 0;
    int left = 0, right = n - 1;
    while (left < right) {
        if (s[left] == s[right]) {
            left++;
            right--;
        } else {
            int i = right;
            while (i > left && s[i] != s[left]) i--;
            if (i == left) {
                char temp = s[left];
                s[left] = s[left + 1];
                s[left + 1] = temp;
                res++;
            } else {
                while (i < right) {
                    char temp = s[i];
                    s[i] = s[i + 1];
                    s[i + 1] = temp;
                    res++;
                    i++;
                }
                left++;
                right--;
            }
        }
    }
    free(count);
    return res;
}