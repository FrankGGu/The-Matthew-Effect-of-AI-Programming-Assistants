#include <vector>
#include <string>
#include <algorithm>

bool isSubsequence(const std::string& s1, const std::string& s2) {
    int i = 0, j = 0;
    while (i < s1.length() && j < s2.length()) {
        if (s1[i] == s2[j]) {
            i++;
        }
        j++;
    }
    return i == s1.length();
}

class Solution {
public:
    int findLUSlength(std::vector<std::string>& strs) {
        // Sort strings by length in descending order.
        // This ensures that the first string we find that satisfies the LUS condition
        // will be the longest possible LUS.
        std::sort(strs.begin(), strs.end(), [](const std::string& a, const std::string& b) {
            return a.length() > b.length();
        });

        int n = strs.size();

        // Iterate through each string in the sorted list
        for (int i = 0; i < n; ++i) {
            bool is_uncommon = true;
            // Check if strs[i] is a subsequence of any other string strs[j]
            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    continue; // Don't compare a string with itself
                }
                // If strs[i] is a subsequence of strs[j], then strs[i] cannot be an LUS.
                // This includes the case where strs[i] == strs[j] (duplicates),
                // as a string is a subsequence of itself.
                if (isSubsequence(strs[i], strs[j])) {
                    is_uncommon = false;
                    break; // No need to check further for this strs[i]
                }
            }

            // If strs[i] was not a subsequence of any other string, it's an LUS.
            // Since we sorted by length descending, this is the longest one.
            if (is_uncommon) {
                return strs[i].length();
            }
        }

        // If no such string is found after checking all possibilities, return -1.
        return -1;
    }
};