class Solution {
public:
    int sumOfFlooredPairs(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        vector<long long> count(maxNum + 1, 0);
        vector<long long> sum(maxNum + 1, 0);

        for (int num : nums) {
            count[num]++;
        }

        for (int i = 1; i <= maxNum; i++) {
            for (int j = i; j <= maxNum; j += i) {
                sum[j] += count[i];
            }
        }

        long long result = 0;
        for (int num : nums) {
            result += sum[num];
        }

        return result;
    }
};