class Solution {
public:
    int maximumTop(vector<int>& nums, int k) {
        int n = nums.size();
        if (k == 0) return n > 0 ? nums[0] : 0;
        if (n == 0) return 0;

        int maxElement = 0;
        for (int i = 0; i < min(k, n); ++i) {
            maxElement = max(maxElement, nums[i]);
        }
        if (k < n) {
            maxElement = max(maxElement, nums[k]);
        }
        return maxElement;
    }
};