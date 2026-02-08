#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>

class Solution {
private:
    std::unordered_set<std::string> dict;
    std::unordered_map<int, std::vector<std::string>> memo;
    std::string s_str;

    std::vector<std::string> backtrack(int start_index) {
        // Base case: If we reached the end of the string,
        // it means we successfully formed a sentence. Return a list containing an empty string.
        // This empty string will be the "suffix" for the last word, meaning no space is needed after it.
        if (start_index == s_str.length()) {
            return {""};
        }

        // Memoization check: If results for this start_index are already computed, return them.
        if (memo.count(start_index)) {
            return memo[start_index];
        }

        std::vector<std::string> results;
        // Iterate from the current start_index to find all possible words
        for (int i = start_index; i < s_str.length(); ++i) {
            std::string word = s_str.substr(start_index, i - start_index + 1);

            // If the current word is found in the dictionary
            if (dict.count(word)) {
                // Recursively find all possible suffixes starting from the next index (i + 1)
                std::vector<std::string> suffixes = backtrack(i + 1);

                // Combine the current word with each valid suffix
                for (const std::string& suffix : suffixes) {
                    if (suffix.empty()) {
                        // If the suffix is empty, it means 'word' is the last word in the sentence.
                        // So, no space is needed after 'word'.
                        results.push_back(word);
                    } else {
                        // Otherwise, add a space between the current word and the suffix.
                        results.push_back(word + " " + suffix);
                    }
                }
            }
        }

        // Store the computed results for the current start_index in memoization table
        memo[start_index] = results;
        return results;
    }

public:
    std::vector<std::string> wordBreak(std::string s, std::vector<std::string>& wordDict) {
        s_str = s;
        // Populate the dictionary for efficient O(1) average time lookups
        for (const std::string& word : wordDict) {
            dict.insert(word);
        }

        // Start the backtracking process from the beginning of the string (index 0)
        return backtrack(0);
    }
};