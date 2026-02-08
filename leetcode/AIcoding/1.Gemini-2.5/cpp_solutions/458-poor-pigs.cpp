#include <cmath>

class Solution {
public:
    int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if (buckets == 1) return 0;
        int time = minutesToTest / minutesToDie;
        return ceil(log(buckets) / log(time + 1));
    }
};