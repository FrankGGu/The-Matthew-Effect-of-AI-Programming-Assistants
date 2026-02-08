#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

class Solution {
private:
    vector<vector<int>> rectangles;
    vector<int> prefixSums;

public:
    Solution(vector<vector<int>>& rects) : rectangles(rects) {
        prefixSums.push_back(0);
        for (const auto& rect : rectangles) {
            int area = (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            prefixSums.push_back(prefixSums.back() + area);
        }
        srand(time(0));
    }

    vector<int> pick() {
        int total = prefixSums.back();
        int randArea = rand() % total;

        int left = 0, right = prefixSums.size() - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] <= randArea) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int index = left - 1;
        const auto& rect = rectangles[index];
        int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];

        int width = x2 - x1 + 1;
        int height = y2 - y1 + 1;

        int x = x1 + rand() % width;
        int y = y1 + rand() % height;

        return {x, y};
    }
};