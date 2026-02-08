#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countLargestRectangles(vector<vector<int>>& rectangles) {
        vector<int> heights;
        for (const auto& rect : rectangles) {
            int side = min(rect[0], rect[1]);
            heights.push_back(side);
        }
        int maxSide = *max_element(heights.begin(), heights.end());
        int count = 0;
        for (int h : heights) {
            if (h == maxSide) {
                count++;
            }
        }
        return count;
    }
};