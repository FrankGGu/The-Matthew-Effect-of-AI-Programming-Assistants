class Solution {
public:
    vector<int> beautifulIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> result;

        for (int i = 0; i < n; i++) {
            if ((i == 0 || nums[i] > nums[i - 1]) && (i == n - 1 || nums[i] < nums[i + 1])) {
                result.push_back(i);
            }
        }

        return result;
    }
};