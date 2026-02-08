class Solution {
public:
    int minimumRightShifts(vector<int>& nums) {
        int n = nums.size();
        int pivot = 0;
        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[i-1]) {
                pivot = i;
                break;
            }
        }
        if (pivot == 0) return 0;
        for (int i = pivot + 1; i < n; ++i) {
            if (nums[i] < nums[i-1]) {
                return -1;
            }
        }
        if (nums.back() <= nums.front()) {
            return n - pivot;
        } else {
            return -1;
        }
    }
};