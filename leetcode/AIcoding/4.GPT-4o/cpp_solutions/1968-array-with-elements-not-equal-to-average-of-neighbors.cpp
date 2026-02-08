class Solution {
public:
    vector<int> rearrangeArray(vector<int>& nums) {
        vector<int> result(nums.size());
        int n = nums.size();
        vector<int> positive, negative;

        for (int num : nums) {
            if (num > 0) positive.push_back(num);
            else negative.push_back(num);
        }

        for (int i = 0; i < n; ++i) {
            result[i] = (i % 2 == 0) ? positive[i / 2] : negative[i / 2];
        }

        return result;
    }
};