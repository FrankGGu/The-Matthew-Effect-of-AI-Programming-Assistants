class Solution {
public:
    int countWays(vector<int>& nums) {
        long long mod = 1e9 + 7;
        int n = nums.size();
        unordered_map<long long, int> primeCount;

        for (int num : nums) {
            unordered_map<long long, int> currentFactors;
            for (long long i = 2; i * i <= num; ++i) {
                while (num % i == 0) {
                    currentFactors[i]++;
                    num /= i;
                }
            }
            if (num > 1) {
                currentFactors[num]++;
            }
            for (const auto& [prime, count] : currentFactors) {
                primeCount[prime] += count;
            }
        }

        long long result = 1;
        for (const auto& [prime, count] : primeCount) {
            result = (result * (count + 1)) % mod;
        }

        return result;
    }
};