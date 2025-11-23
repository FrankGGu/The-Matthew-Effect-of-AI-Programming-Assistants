#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findPeaks(vector<int>& nums) {
        vector<int> peaks;
        for (int i = 1; i < nums.size() - 1; ++i) {
            if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
                peaks.push_back(i);
            }
        }
        return peaks;
    }
};