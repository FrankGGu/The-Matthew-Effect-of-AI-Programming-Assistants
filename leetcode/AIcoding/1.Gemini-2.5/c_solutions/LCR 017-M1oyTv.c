#include <limits.h>
#include <stdlib.h>
#include <string.h>

char* minWindow(char* s, char* t) {
    int s_len = strlen(s);
    int t_len = strlen(t);

    if (t_len == 0 || s_len == 0) {
        return "";
    }

    // Frequency map for characters in t
    int target_freq[128] = {0};
    // Frequency map for characters in the current window
    int window_freq[128] = {0};

    // Count of unique characters in t
    int required_chars = 0; 
    for (int i = 0; i < t_len; i++) {
        if (target_freq[t[i]] == 0) {
            required_chars++;
        }
        target_freq[t[i]]++;
    }

    int left = 0;
    int right = 0;
    // Count of unique characters from t that are currently satisfied in the window
    int formed_chars = 0; 

    int min_len = INT_MAX;
    int min_start = 0;

    while (right < s_len) {
        char r_char = s[right];
        window_freq[r_char]++;

        // If the current character is part of t and its count in the window
        // matches the required count in t, increment formed_chars.
        if (target_freq[r_char] > 0 && window_freq[r_char] == target_freq[r_char]) {
            formed_chars++;
        }

        // Try to shrink the window from the left if all required characters are found
        while (formed_chars == required_chars && left <= right) {
            // Update minimum window if current is smaller
            if (right - left + 1 < min_len) {
                min_len = right - left + 1;
                min_start = left;
            }

            char l_char = s[left];
            // If the character being removed from the left is part of t
            // and its count in the window was exactly what was required,
            // decrement formed_chars as this requirement is no longer met.
            if (target_freq[l_char] > 0 && window_freq[l_char] == target_freq[l_char]) {
                formed_chars--;
            }
            window_freq[l_char]--;
            left++;
        }
        right++;
    }

    if (min_len == INT_MAX) {
        return "";
    } else {
        char* result = (char*)malloc(min_len + 1);
        if (result == NULL) {
            return ""; // Handle malloc failure
        }
        strncpy(result, s + min_start, min_len);
        result[min_len] = '\0';
        return result;
    }
}