class Solution {
public:
    int countTriplets(vector<int>& nums) {
        unordered_map<int, int> freq;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                freq[nums[i] & nums[j]]++;
            }
        }
        int res = 0;
        for (int num : nums) {
            for (auto& [k, cnt] : freq) {
                if ((num & k) == 0) {
                    res += cnt;
                }
            }
        }
        return res;
    }
};