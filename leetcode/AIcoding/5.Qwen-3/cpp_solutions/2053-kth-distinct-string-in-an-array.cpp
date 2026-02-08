#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    std::string kthDistinct(std::vector<std::string>& arr, int k) {
        std::unordered_map<std::string, int> count;
        for (const auto& s : arr) {
            count[s]++;
        }
        for (const auto& s : arr) {
            if (count[s] == 1) {
                if (k == 1) {
                    return s;
                }
                k--;
            }
        }
        return "";
    }
};