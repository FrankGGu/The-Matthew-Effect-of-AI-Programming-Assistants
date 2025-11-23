#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int longestPalindrome(std::vector<std::string>& words) {
        std::unordered_map<std::string, int> freq_map;
        for (const std::string& word : words) {
            freq_map[word]++;
        }

        int total_length = 0;
        bool middle_word_used = false;

        for (auto& entry : freq_map) {
            std::string word = entry.first;
            int count = entry.second;

            if (count == 0) {
                continue;
            }

            // Case 1: Palindromic word (e.g., "aa", "bb")
            if (word[0] == word[1]) {
                total_length += (count / 2) * 4; // Each pair of "aa" contributes 4 to length ("aaaa")
                if (count % 2 == 1) {
                    middle_word_used = true; // Mark that we have an odd count of a palindromic word
                }
                entry.second = 0; // Mark this word type as fully processed for its symmetric pairs
            } 
            // Case 2: Non-palindromic word (e.g., "ab")
            else {
                std::string rev_word = "";
                rev_word += word[1];
                rev_word += word[0];

                if (freq_map.count(rev_word) && freq_map[rev_word] > 0) {
                    int pairs = std::min(count, freq_map[rev_word]);
                    total_length += pairs * 4; // Each pair of "ab" and "ba" contributes 4 to length ("abba")

                    // Mark these words as used
                    entry.second -= pairs;
                    freq_map[rev_word] -= pairs;
                }
            }
        }

        // After forming all possible pairs, if we have any single palindromic word left (e.g., one "gg"),
        // we can place one such word in the very center of the longest palindrome.
        if (middle_word_used) {
            total_length += 2;
        }

        return total_length;
    }
};