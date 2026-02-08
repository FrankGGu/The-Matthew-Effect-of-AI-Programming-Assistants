#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm> // For std::reverse and std::min

class Solution {
public:
    int longestPalindrome(std::vector<std::string>& words) {
        std::unordered_map<std::string, int> freq;
        for (const std::string& word : words) {
            freq[word]++;
        }

        int total_length = 0;
        bool has_center_xx = false;

        for (auto it = freq.begin(); it != freq.end(); ++it) {
            std::string word = it->first;
            int count = it->second;

            if (count == 0) { // This word has already been fully used up
                continue;
            }

            std::string reversed_word = word;
            std::reverse(reversed_word.begin(), reversed_word.end());

            if (word == reversed_word) { // Word is of the form "aa"
                total_length += 4 * (count / 2); // Pair up "aa" with another "aa"
                if (count % 2 == 1) { // If there's an odd count, one can be a center
                    has_center_xx = true;
                }
                it->second = 0; // Mark this word's count as 0, so it's not processed again
            } else { // Word is of the form "ab" (where a != b)
                // Check if its reverse "ba" exists and has a positive count
                if (freq.count(reversed_word) && freq.at(reversed_word) > 0) {
                    int num_pairs = std::min(count, freq.at(reversed_word));
                    total_length += 4 * num_pairs; // Each pair "ab" + "ba" contributes 4 chars

                    // Mark both words as used by decrementing their counts
                    it->second -= num_pairs;
                    freq[reversed_word] -= num_pairs;
                }
            }
        }

        if (has_center_xx) {
            total_length += 2; // Add 2 for the single center word like "aa"
        }

        return total_length;
    }
};