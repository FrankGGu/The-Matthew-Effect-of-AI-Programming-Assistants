#include <string.h>

long long countSubstrings(char * s, int k){
    long long ans = 0;
    int left = 0;
    int freq[26] = {0}; // Frequency array for lowercase English letters
    int n = strlen(s);

    for (int right = 0; right < n; ++right) {
        // Add the current character s[right] to the window
        freq[s[right] - 'a']++;

        // If the frequency of s[right] exceeds k, shrink the window from the left
        // until s[right]'s frequency is back to k (or less).
        // This ensures that the current character s[right] does not violate the constraint.
        // Since all characters in s[left...right-1] already satisfied the constraint
        // (due to previous iterations), only s[right] could potentially violate it now.
        while (freq[s[right] - 'a'] > k) {
            freq[s[left] - 'a']--;
            left++;
        }

        // At this point, the window s[left...right] satisfies the k-constraint.
        // All substrings ending at 'right' and starting from 'left' up to 'right'
        // are also valid. There are (right - left + 1) such substrings.
        ans += (right - left + 1);
    }

    return ans;
}