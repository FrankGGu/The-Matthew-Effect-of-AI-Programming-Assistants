class Solution {
public:
    int countExcellentPairs(vector<int>& nums, int k) {
        unordered_set<int> uniqueNums(nums.begin(), nums.end());
        vector<int> bitCount(32, 0);

        for (int num : uniqueNums) {
            int count = __builtin_popcount(num);
            bitCount[count]++;
        }

        long long result = 0;
        for (int i = 0; i < 32; i++) {
            if (bitCount[i] > 0) {
                for (int j = 0; j < 32; j++) {
                    if (bitCount[j] > 0 && (i + j) >= k) {
                        result += (long long)bitCount[i] * bitCount[j];
                    }
                }
            }
        }

        return result;
    }
};