class Solution {
public:
    long long countPairs(vector<int>& nums, int k) {
        int n = nums.size();
        unordered_map<int, int> remainderCount;
        long long result = 0;

        for (int num : nums) {
            int remainder = num % k;
            int complement = (k - remainder) % k;
            if (remainderCount.find(complement) != remainderCount.end()) {
                result += remainderCount[complement];
            }
            remainderCount[remainder]++;
        }

        return result;
    }
};