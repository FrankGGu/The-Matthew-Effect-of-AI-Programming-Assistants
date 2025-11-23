#include <vector>
#include <string>

class Solution {
public:
    bool is_vowel_char(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    std::vector<int> vowelStrings(std::vector<std::string>& words, std::vector<std::vector<int>>& queries) {
        int n = words.size();
        std::vector<int> prefix_vowel_counts(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            bool starts_with_vowel = is_vowel_char(words[i][0]);
            bool ends_with_vowel = is_vowel_char(words[i][words[i].length() - 1]);

            prefix_vowel_counts[i + 1] = prefix_vowel_counts[i];
            if (starts_with_vowel && ends_with_vowel) {
                prefix_vowel_counts[i + 1]++;
            }
        }

        std::vector<int> results;
        results.reserve(queries.size());
        for (const auto& query : queries) {
            int start = query[0];
            int end = query[1];
            results.push_back(prefix_vowel_counts[end + 1] - prefix_vowel_counts[start]);
        }

        return results;
    }
};