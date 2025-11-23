#include <string.h> // For strlen

int minimumCharactersToRemove(char * s, int k) {
    int n = strlen(s);
    int total_counts[3] = {0, 0, 0};

    for (int i = 0; i < n; i++) {
        total_counts[s[i] - 'a']++;
    }

    int target_a = total_counts[0] - k;
    int target_b = total_counts[1] - k;
    int target_c = total_counts[2] - k;

    int max_len = 0;
    int left = 0;
    int current_counts[3] = {0, 0, 0};

    for (int right = 0; right < n; right++) {
        current_counts[s[right] - 'a']++;

        while (current_counts[0] > target_a || 
               current_counts[1] > target_b || 
               current_counts[2] > target_c) {
            current_counts[s[left] - 'a']--;
            left++;
        }

        if (right - left + 1 > max_len) {
            max_len = right - left + 1;
        }
    }

    return n - max_len;
}