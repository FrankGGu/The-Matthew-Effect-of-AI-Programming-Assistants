#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long interchangeableRectangles(vector<vector<int>>& rectangles) {
        unordered_map<double, long long> ratioCount;
        for (const auto& rect : rectangles) {
            double ratio = (double)rect[0] / rect[1];
            ratioCount[ratio]++;
        }

        long long result = 0;
        for (const auto& [ratio, count] : ratioCount) {
            if (count >= 2) {
                result += count * (count - 1) / 2;
            }
        }

        return result;
    }
};