#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctPrimeFactors(vector<int>& nums) {
        unordered_set<int> primeFactors;
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