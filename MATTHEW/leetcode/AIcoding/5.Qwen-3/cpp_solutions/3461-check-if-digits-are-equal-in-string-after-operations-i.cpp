#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    bool areDigitsEqual(std::string s) {
        std::unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        int first = -1;
        for (auto& [c, cnt] : count) {
            if (first == -1) {
                first = cnt;
            } else {
                if (cnt != first) {
                    return false;
                }
            }
        }
        return true;
    }
};