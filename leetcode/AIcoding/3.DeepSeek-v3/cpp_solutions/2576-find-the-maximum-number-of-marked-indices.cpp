class Solution {
public:
    int maxNumOfMarkedIndices(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0, right = n / 2;
        int res = 0;
        while (left < n / 2 && right < n) {
            if (nums[left] * 2 <= nums[right]) {
                res += 2;
                left++;
                right++;
            } else {
                right++;
            }
        }
        return res;
    }
};