class Solution {
public:
    int subarraysDivByK(vector<int>& nums, int k) {
        unordered_map<int, int> prefix_map;
        prefix_map[0] = 1;
        int sum = 0;
        int count = 0;
        for (int num : nums) {
            sum += num;
            int mod = (sum % k + k) % k;
            if (prefix_map.find(mod) != prefix_map.end()) {
                count += prefix_map[mod];
            }
            prefix_map[mod]++;
        }
        return count;
    }
};