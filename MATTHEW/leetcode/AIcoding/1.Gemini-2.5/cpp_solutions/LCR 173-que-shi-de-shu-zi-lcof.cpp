#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    std::vector<int> rollCall(std::vector<std::string>& names) {
        std::unordered_map<std::string, int> freq;
        for (const std::string& name : names) {
            freq[name]++;
        }

        std::vector<int> ans;
        ans.reserve(names.size());
        for (const std::string& name : names) {
            ans.push_back(freq[name]);
        }

        return ans;
    }
};