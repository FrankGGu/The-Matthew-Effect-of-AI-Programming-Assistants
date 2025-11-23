#include <string>
#include <vector>

class Solution {
public:
    bool checkDistances(std::string s, std::vector<int>& distance) {
        std::vector<int> first_occurrence(26, -1);

        for (int i = 0; i < s.length(); ++i) {
            int char_idx = s[i] - 'a';
            if (first_occurrence[char_idx] == -1) {
                first_occurrence[char_idx] = i;
            } else {
                int actual_distance = i - first_occurrence[char_idx] - 1;
                if (actual_distance != distance[char_idx]) {
                    return false;
                }
            }
        }

        return true;
    }
};