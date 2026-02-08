#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubstring(char *s) {
    int n = strlen(s);
    int max_len = 0;
    int current_len = 1;
    for (int i = 1; i < n; i++) {
        if ((s[i] == 'a' && s[i-1] == 'a') || 
            (s[i] == 'e' && s[i-1] == 'a') || 
            (s[i] == 'i' && s[i-1] == 'a') || 
            (s[i] == 'o' && s[i-1] == 'a') || 
            (s[i] == 'u' && s[i-1] == 'a') ||
            (s[i] == 'e' && s[i-1] == 'e') || 
            (s[i] == 'i' && s[i-1] == 'e') || 
            (s[i] == 'o' && s[i-1] == 'e') || 
            (s[i] == 'u' && s[i-1] == 'e') ||
            (s[i] == 'i' && s[i-1] == 'i') || 
            (s[i] == 'o' && s[i-1] == 'i') || 
            (s[i] == 'u' && s[i-1] == 'i') ||
            (s[i] == 'o' && s[i-1] == 'o') || 
            (s[i] == 'u' && s[i-1] == 'o') ||
            (s[i] == 'u' && s[i-1] == 'u')) {
            current_len++;
        } else {
            current_len = 1;
        }
        if (current_len > max_len) {
            max_len = current_len;
        }
    }
    return max_len;
}