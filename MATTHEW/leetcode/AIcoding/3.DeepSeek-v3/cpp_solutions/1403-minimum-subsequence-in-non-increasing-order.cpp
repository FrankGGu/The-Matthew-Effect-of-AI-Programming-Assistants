class Solution {
public:
    vector<int> minSubsequence(vector<int>& nums) {
        sort(nums.begin(), nums.end(), greater<int>());
        int total = accumulate(nums.begin(), nums.end(), 0);
        int sum = 0;
        vector<int> res;
        for (int num : nums) {
            sum += num;
            res.push_back(num);
            if (sum > total - sum) {
                break;
            }
        }
        return res;
    }
};