#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    std::string restoreString(std::string s, std::vector<int>& indices) {
        std::string result = s;
        for (int i = 0; i < s.length(); ++i) {
            result[indices[i]] = s[i];
        }
        return result;
    }
};