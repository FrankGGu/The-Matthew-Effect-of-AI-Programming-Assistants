#include <string.h>
#include <stdlib.h> // For abs, though not strictly needed here
#include <stdio.h> // For debugging, not needed in final solution

int maxScore(char * s){
    int n = strlen(s);
    int left_zeros = 0;
    int right_ones = 0;
    int max_score = 0;

    // Calculate initial total ones in the entire string
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            right_ones++;
        }
    }

    // Iterate through all possible split points
    // A split point 'i' means s[0...i] is left, s[i+1...n-1] is right
    // The problem states "splitting into two non-empty substrings",
    // so the split can be after the first char up to before the last char.
    // This means the left part can have length 1 to n-1.
    // The loop variable 'i' will represent the index of the last character
    // of the left substring.
    for (int i = 0; i < n - 1; i++) {
        if (s[i] == '0') {
            left_zeros++;
        } else { // s[i] == '1'
            right_ones--;
        }

        // Calculate score for the current split
        int current_score = left_zeros + right_ones;

        // Update max_score if current_score is greater
        if (current_score > max_score) {
            max_score = current_score;
        }
    }

    return max_score;
}