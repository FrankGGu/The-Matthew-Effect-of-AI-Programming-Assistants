#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minMovesToMakePalindrome(std::string s) {
        int n = s.length();
        int left = 0;
        int right = n - 1;
        int moves = 0;

        while (left < right) {
            if (s[left] == s[right]) {
                left++;
                right--;
            } else {
                int k = right;
                while (k > left && s[k] != s[left]) {
                    k--;
                }

                if (k == left) { // s[left] is the unique middle character
                    moves += (n / 2 - left); // Moves to bring it to the center
                    // No actual string modification needed for this character, it's conceptually placed
                    // and we move on from the left.
                    left++;
                } else { // Found a match s[k] for s[left]
                    // Shift s[k] to s[right]'s position
                    moves += (right - k);
                    char temp = s[k];
                    for (int i = k; i < right; ++i) {
                        s[i] = s[i+1];
                    }
                    s[right] = temp;

                    left++;
                    right--;
                }
            }
        }
        return moves;
    }
};