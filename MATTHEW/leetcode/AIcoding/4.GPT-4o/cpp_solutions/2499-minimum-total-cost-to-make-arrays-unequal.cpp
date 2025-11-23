class Solution {
public:
    long long minimumTotalCost(vector<int>& nums) {
        long long cost = 0;
        unordered_map<int, int> freq;

        for (int num : nums) {
            freq[num]++;
        }

        for (const auto& [num, count] : freq) {
            if (count > 1) {
                cost += (count - 1) * num;
            }
        }

        return cost;
    }
};