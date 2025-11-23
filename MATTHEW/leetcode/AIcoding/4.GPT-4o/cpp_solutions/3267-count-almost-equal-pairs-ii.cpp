class Solution {
public:
    long long countPairs(vector<int>& nums) {
        unordered_map<int, long long> count;
        long long result = 0;

        for (int num : nums) {
            result += count[num - 1] + count[num] + count[num + 1];
            count[num]++;
        }

        return result;
    }
};