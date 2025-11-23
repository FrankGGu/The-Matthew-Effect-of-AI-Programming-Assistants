#include <vector>
#include <unordered_map>

class Solution {
public:
    int countPairs(std::vector<int>& deliciousness) {
        std::unordered_map<int, int> counts;
        long long ans = 0;
        int mod = 1e9 + 7;

        for (int d : deliciousness) {
            for (int i = 0; i <= 21; ++i) {
                int p = 1 << i;
                int complement = p - d;
                if (counts.count(complement)) {
                    ans += counts.at(complement);
                }
            }
            counts[d]++;
        }

        return ans % mod;
    }
};