#include <vector>
#include <unordered_set>

class Solution {
public:
    int distinctPrimeFactors(std::vector<int>& nums) {
        std::unordered_set<int> primeFactors;
        for (int num : nums) {
            int n = num;
            for (int i = 2; i * i <= n; ++i) {
                while (n % i == 0) {
                    primeFactors.insert(i);
                    n /= i;
                }
            }
            if (n > 1) {
                primeFactors.insert(n);
            }
        }
        return primeFactors.size();
    }
};