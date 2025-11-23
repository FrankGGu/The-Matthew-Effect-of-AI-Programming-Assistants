class Solution {
public:
    int distinctPrimeFactors(vector<int>& nums) {
        unordered_set<int> primes;
        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    primes.insert(i);
                    while (num % i == 0) {
                        num /= i;
                    }
                }
            }
            if (num > 1) {
                primes.insert(num);
            }
        }
        return primes.size();
    }
};