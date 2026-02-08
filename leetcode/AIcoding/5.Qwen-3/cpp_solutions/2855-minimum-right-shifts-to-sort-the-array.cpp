#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minRightShifts(vector<int>& nums) {
        int n = nums.size();
        int pos = 0;
        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[i - 1]) {
                pos = i;
                break;
            }
        }
        for (int i = pos; i < n - 1; ++i) {
            if (nums[i] > nums[i + 1]) {
                return -1;
            }
        }
        for (int i = 0; i < pos - 1; ++i) {
            if (nums[i] > nums[i + 1]) {
                return -1;
            }
        }
        return (n - pos) % n;
    }
};