#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string repeatLimitedString(std::string s, int repeatLimit) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        std::string result = "";

        // Iterate from 'z' (index 25) down to 'a' (index 0)
        for (int i = 25; i >= 0; ) {
            if (freq[i] == 0) {
                // Current character is exhausted or never existed, move to the next smaller character
                i--;
                continue;
            }

            // Append current character 'i' as many times as possible, up to repeatLimit
            int count_to_append = std::min(freq[i], repeatLimit);
            for (int k = 0; k < count_to_append; ++k) {
                result += (char)('a' + i);
                freq[i]--;
            }

            if (freq[i] > 0) {
                // If freq[i] is still > 0, it means we hit repeatLimit for character 'i'.
                // We must insert a smaller character if available to break the limit.

                // Find the next largest available character (smaller than 'i')
                int j = i - 1;
                while (j >= 0 && freq[j] == 0) {
                    j--;
                }

                if (j < 0) {
                    // No smaller character available to break the limit, we are done.
                    break;
                } else {
                    // Append the smaller character once
                    result += (char)('a' + j);
                    freq[j]--;
                    // After appending character 'j', we can potentially append character 'i' again
                    // in the next iteration of the outer loop. So, 'i' remains the same.
                }
            } else {
                // Current character 'i' is exhausted, move to the next smaller character.
                i--;
            }
        }

        return result;
    }
};