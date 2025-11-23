class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int goal) {
        unordered_map<int, int> count;
        count[0] = 1;
        int sum = 0;
        int res = 0;
        for (int num : nums) {
            sum += num;
            res += count[sum - goal];
            count[sum]++;
        }
        return res;
    }
};