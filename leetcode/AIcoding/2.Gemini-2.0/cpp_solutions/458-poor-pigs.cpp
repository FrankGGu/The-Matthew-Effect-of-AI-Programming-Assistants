#include <cmath>

class Solution {
public:
    int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if (buckets == 1) return 0;
        int t = minutesToTest / minutesToDie;
        return ceil(log(buckets) / log(t + 1));
    }
};