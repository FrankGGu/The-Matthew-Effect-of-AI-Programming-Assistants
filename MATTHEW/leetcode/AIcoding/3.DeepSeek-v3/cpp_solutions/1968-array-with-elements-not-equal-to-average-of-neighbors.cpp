class Solution {
public:
    vector<int> rearrangeArray(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<int> res;
        int left = 0, right = nums.size() - 1;
        while (left <= right) {
            if (left == right) {
                res.push_back(nums[left]);
            } else {
                res.push_back(nums[left]);
                res.push_back(nums[right]);
            }
            left++;
            right--;
        }
        return res;
    }
};