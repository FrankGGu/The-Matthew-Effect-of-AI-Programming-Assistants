class Solution {
public:
    int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if (buckets == 1) {
            return 0;
        }
        int times = minutesToTest / minutesToDie;
        int base = times + 1;
        int pigs = 0;
        long total = 1;
        while (total < buckets) {
            pigs++;
            total *= base;
        }
        return pigs;
    }
};