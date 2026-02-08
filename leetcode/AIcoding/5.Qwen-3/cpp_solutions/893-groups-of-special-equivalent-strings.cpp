#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int numSpecialEquivGroups(std::vector<std::string>& A) {
        std::unordered_map<std::string, int> groups;
        for (const auto& s : A) {
            std::string key = "";
            for (int i = 0; i < s.size(); ++i) {
                if (i % 2 == 0) {
                    key += s[i];
                } else {
                    key += s[i];
                }
            }
            std::sort(key.begin(), key.end());
            groups[key]++;
        }
        return groups.size();
    }
};