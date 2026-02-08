#include <string>
#include <unordered_set>
#include <algorithm> // For std::max

class Solution {
public:
    int max_unique_splits;

    void backtrack(int index, std::unordered_set<std::string>& unique_substrings, const std::string& s) {
        if (index == s.length()) {
            max_unique_splits = std::max(max_unique_splits, (int)unique_substrings.size());
            return;
        }

        for (int i = index; i < s.length(); ++i) {
            std::string current_sub = s.substr(index, i - index + 1);

            if (unique_substrings.find(current_sub) == unique_substrings.end()) {
                unique_substrings.insert(current_sub);
                backtrack(i + 1, unique_substrings, s);
                unique_substrings.erase(current_sub); // Backtrack
            }
        }
    }

    int maxUniqueSplits(std::string s) {
        max_unique_splits = 0;
        std::unordered_set<std::string> unique_substrings;
        backtrack(0, unique_substrings, s);
        return max_unique_splits;
    }
};