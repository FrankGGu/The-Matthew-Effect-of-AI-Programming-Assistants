#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int numSpecialEquivGroups(std::vector<std::string>& A) {
        std::unordered_set<std::string> groups;

        for (const auto& str : A) {
            std::string odd, even;
            for (int i = 0; i < str.size(); ++i) {
                if (i % 2 == 0) {
                    even += str[i];
                } else {
                    odd += str[i];
                }
            }
            std::sort(odd.begin(), odd.end());
            std::sort(even.begin(), even.end());
            groups.insert(odd + even);
        }

        return groups.size();
    }
};