#include <vector>
#include <string>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<std::string>> groupAnagrams(std::vector<std::string>& strs) {
        std::map<std::string, std::vector<std::string>> groups;

        for (const std::string& s : strs) {
            std::string sorted_s = s;
            std::sort(sorted_s.begin(), sorted_s.end());
            groups[sorted_s].push_back(s);
        }

        std::vector<std::vector<std::string>> result;
        for (auto const& [key, val] : groups) {
            result.push_back(val);
        }

        return result;
    }
};