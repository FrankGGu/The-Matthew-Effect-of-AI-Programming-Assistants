class Solution {
public:
    int minimizeMax(vector<int>& nums, int p) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums.back() - nums.front();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFormPairs(nums, mid, p)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    bool canFormPairs(vector<int>& nums, int maxDiff, int p) {
        int count = 0;
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] - nums[i - 1] <= maxDiff) {
                count++;
                i++; // Skip the next element as it's paired
            }
        }
        return count >= p;
    }
};