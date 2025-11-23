#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> longestObstacleCourseAtEachPosition(vector<int>& obstacles) {
        vector<int> res;
        vector<int> tails;

        for (int obstacle : obstacles) {
            int left = 0, right = tails.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (tails[mid] <= obstacle) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if (left == tails.size()) {
                tails.push_back(obstacle);
            } else {
                tails[left] = obstacle;
            }
            res.push_back(left + 1);
        }

        return res;
    }
};