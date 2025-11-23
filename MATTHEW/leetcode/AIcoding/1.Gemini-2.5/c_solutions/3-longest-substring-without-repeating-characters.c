#include <string.h> // For strlen

int max(int a, int b) {
    return a > b ? a : b;
}

int lengthOfLongestSubstring(char * s){
    // charIndex array stores the last seen index of each character (ASCII 0-127)
    // Initialize with -1 to indicate no character has been seen yet
    int charIndex[128]; 
    for (int i = 0; i < 128; i++) {
        charIndex[i] = -1;
    }

    int maxLength = 0;
    int left = 0; // Left pointer of the sliding window
    int n = strlen(s);

    // Iterate with the right pointer
    for (int right = 0; right < n; right++) {
        char currentChar = s[right];

        // If the current character has been seen before AND its last seen index
        // is within the current window (i.e., charIndex[currentChar] >= left)
        if (charIndex[currentChar] != -1 && charIndex[currentChar] >= left) {
            // Move the left pointer to the position right after the last occurrence
            // of the repeating character. This effectively shrinks the window.
            left = charIndex[currentChar] + 1;
        }

        // Update the last seen index of the current character to its current position
        charIndex[currentChar] = right;

        // Calculate the current window length (right - left + 1) and update maxLength
        maxLength = max(maxLength, right - left + 1);
    }

    return maxLength;
}