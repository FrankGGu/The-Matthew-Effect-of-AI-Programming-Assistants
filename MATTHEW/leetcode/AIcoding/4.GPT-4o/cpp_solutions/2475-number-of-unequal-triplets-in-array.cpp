class Solution {
public:
    int unequalTriplets(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        long totalTriplets = 0, prefixSum = 0;
        for (auto& [num, cnt] : count) {
            totalTriplets += prefixSum * cnt * (nums.size() - prefixSum - cnt);
            prefixSum += cnt;
        }

        return totalTriplets;
    }
};