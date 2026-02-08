#include <set>

class Solution {
public:
    int countPrimeSetBits(int L, int R) {
        std::set<int> primes = {2, 3, 5, 7, 11, 13, 17, 19};
        int count = 0;
        for (int i = L; i <= R; ++i) {
            int setBits = __builtin_popcount(i);
            if (primes.count(setBits)) {
                count++;
            }
        }
        return count;
    }
};