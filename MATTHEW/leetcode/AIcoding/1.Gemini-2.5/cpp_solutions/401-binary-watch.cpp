#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> readBinaryWatch(int turnedOn) {
        std::vector<std::string> result;
        for (int h = 0; h < 12; ++h) {
            for (int m = 0; m < 60; ++m) {
                if (__builtin_popcount(h) + __builtin_popcount(m) == turnedOn) {
                    result.push_back(std::to_string(h) + ":" + (m < 10 ? "0" : "") + std::to_string(m));
                }
            }
        }
        return result;
    }
};