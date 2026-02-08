class Solution {
public:
    int countDistinct(vector<int>& nums, int k, int p) {
        set<vector<int>> distinctSubarrays;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            vector<int> subarray;
            int count = 0;
            for (int j = i; j < n; ++j) {
                if (nums[j] % p == 0) {
                    ++count;
                }
                if (count > k) {
                    break;
                }
                subarray.push_back(nums[j]);
                distinctSubarrays.insert(subarray);
            }
        }
        return distinctSubarrays.size();
    }
};