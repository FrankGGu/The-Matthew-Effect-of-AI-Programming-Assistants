#include <iostream>
#include <vector>
#include <map>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long interchangeableRectangles(std::vector<std::vector<int>>& rectangles) {
        std::map<std::string, long long> ratioCount;
        long long result = 0;

        for (const auto& rect : rectangles) {
            int width = rect[0];
            int height = rect[1];
            int gcdVal = std::gcd(width, height);
            std::string ratio = std::to_string(width / gcdVal) + ":" + std::to_string(height / gcdVal);
            ratioCount[ratio]++;
        }

        for (const auto& [ratio, count] : ratioCount) {
            if (count >= 2) {
                result += count * (count - 1) / 2;
            }
        }

        return result;
    }
};