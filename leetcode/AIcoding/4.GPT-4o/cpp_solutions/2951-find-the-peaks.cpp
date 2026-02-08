#include <vector>
using namespace std;

class Solution {
public:
    vector<int> findPeakElement(vector<int>& nums) {
        vector<int> peaks;
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            if ((i == 0 || nums[i] > nums[i - 1]) && (i == n - 1 || nums[i] > nums[i + 1])) {
                peaks.push_back(i);
            }
        }
        return peaks;
    }
};