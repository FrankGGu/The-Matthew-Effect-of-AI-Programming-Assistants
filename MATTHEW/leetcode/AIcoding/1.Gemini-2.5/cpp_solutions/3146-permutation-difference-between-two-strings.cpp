#include <string>
#include <vector>
#include <cmath>

class Solution {
public:
    int findPermutationDifference(std::string s, std::string t) {
        std::vector<int> t_indices(26);
        for (int i = 0; i < t.length(); ++i) {
            t_indices[t[i] - 'a'] = i;
        }

        int total_difference = 0;
        for (int i = 0; i < s.length(); ++i) {
            total_difference += std::abs(i - t_indices[s[i] - 'a']);
        }

        return total_difference;
    }
};