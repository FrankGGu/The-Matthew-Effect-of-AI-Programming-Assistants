#include <string.h> // For strlen

int max(int a, int b) {
    return a > b ? a : b;
}

int characterReplacement(char * s, int k){
    // freq array to store the count of each character (A-Z) in the current window
    int freq[26] = {0};

    // left pointer of the sliding window
    int left = 0;

    // max_freq stores the maximum frequency of any character in the current window.
    // It's crucial that this max_freq does not necessarily decrease when 'left' moves,
    // as we are interested in the overall longest window, and a character that was
    // highly frequent in a previous (larger) window might still allow for a long
    // current window.
    int max_freq = 0;

    // max_len stores the maximum length of a valid window found so far
    int max_len = 0;

    // Get the length of the input string
    int n = strlen(s);

    // Iterate with the right pointer to expand the window
    for (int right = 0; right < n; right++) {
        // Increment the frequency of the character at the right pointer
        int char_idx = s[right] - 'A';
        freq[char_idx]++;

        // Update max_freq with the highest frequency seen in the current window
        max_freq = max(max_freq, freq[char_idx]);

        // Calculate the current window length
        int current_window_length = right - left + 1;

        // Check if the current window is valid
        // The number of characters to replace is (current_window_length - max_freq).
        // If this count exceeds k, the window is invalid and needs to be shrunk from the left.
        if (current_window_length - max_freq > k) {
            // Shrink the window by decrementing the frequency of the character at the left pointer
            // and moving the left pointer forward.
            freq[s[left] - 'A']--;
            left++;
            // Note: max_freq is NOT recalculated here. This is a key optimization.
            // The max_freq value continues to represent the highest frequency of any character
            // that was part of the longest valid window encountered so far.
            // If the current window (even with this high max_freq) is too long, we shrink it.
        }

        // The window [left, right] is now a valid candidate (or the largest possible valid window ending at 'right').
        // Update max_len with the current valid window length.
        max_len = max(max_len, right - left + 1);
    }

    return max_len;
}