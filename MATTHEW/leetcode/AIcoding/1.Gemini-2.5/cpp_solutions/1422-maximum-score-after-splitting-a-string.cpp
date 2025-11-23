#include <string>
#include <algorithm>

class Solution {
public:
    int maxScore(std::string s) {
        int n = s.length();
        int max_score = 0;

        int zeros_left_count = 0;
        int ones_right_count = 0;

        // Calculate initial count of ones in the entire string
        // This will represent the ones in the 'right' part before any split
        for (char c : s) {
            if (c == '1') {
                ones_right_count++;
            }
        }

        // Iterate through all possible split points
        // A split at index 'i' means s[0...i] is the left part
        // and s[i+1...n-1] is the right part.
        // 'i' can range from 0 to n-2, ensuring both parts are non-empty.
        for (int i = 0; i < n - 1; ++i) {
            // Update counts based on the character s[i] moving from right to left
            if (s[i] == '0') {
                zeros_left_count++;
            } else { // s[i] == '1'
                ones_right_count--;
            }

            // Calculate the score for the current split
            int current_score = zeros_left_count + ones_right_count;

            // Update the maximum score found so far
            max_score = std::max(max_score, current_score);
        }

        return max_score;
    }
};