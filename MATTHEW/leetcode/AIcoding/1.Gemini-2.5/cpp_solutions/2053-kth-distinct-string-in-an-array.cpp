#include <string>
#include <vector>
#include <unordered_map>

class Solution {
public:
    std::string kthDistinct(std::vector<std::string>& arr, int k) {
        std::unordered_map<std::string, int> counts;
        for (const std::string& s : arr) {
            counts[s]++;
        }

        for (const std::string& s : arr) {
            if (counts[s] == 1) {
                k--;
                if (k == 0) {
                    return s;
                }
            }
        }

        return "";
    }
};