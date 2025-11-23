#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>
#include <set> // Using set to iterate unique words to avoid issues with map modification during iteration

class Solution {
public:
    int longestPalindrome(std::vector<std::string>& words) {
        std::unordered_map<std::string, int> counts;
        for (const std::string& word : words) {
            counts[word]++;
        }

        int ans = 0;
        int max_odd_palindrome_len = 0;

        // Collect unique words to iterate over, as we will modify counts
        std::set<std::string> unique_words_to_process;
        for (const auto& pair : counts) {
            unique_words_to_process.insert(pair.first);
        }

        for (const std::string& word : unique_words_to_process) {
            if (counts[word] == 0) {
                continue; // Already processed or not present
            }

            std::string reversed_word = word;
            std::reverse(reversed_word.begin(), reversed_word.end());

            if (word == reversed_word) {
                // Palindrome word (e.g., "gg", "aa")
                ans += (counts[word] / 2) * 2 * word.length(); // Add pairs
                if (counts[word] % 2 == 1) {
                    // One such word can be used as a center. We pick the longest one.
                    max_odd_palindrome_len = std::max(max_odd_palindrome_len, (int)word.length());
                }
                counts[word] = 0; // Mark as processed
            } else {
                // Non-palindrome word (e.g., "lc")
                if (counts.count(reversed_word) && counts[reversed_word] > 0) {
                    int num_pairs = std::min(counts[word], counts[reversed_word]);
                    ans += num_pairs * 2 * word.length();
                    // Mark these words as processed by setting their counts to 0
                    // This is important to avoid double counting (e.g., "lc" and "cl" being processed twice)
                    counts[word] -= num_pairs;
                    counts[reversed_word] -= num_pairs;
                }
            }
        }

        // If there was any odd count palindrome word, one can be placed in the center
        ans += max_odd_palindrome_len;

        return ans;
    }
};