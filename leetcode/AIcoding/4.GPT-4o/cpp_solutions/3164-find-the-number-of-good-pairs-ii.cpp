class Solution {
public:
    long long countGood(int a, int b, int c, int d) {
        long long total = 0;
        total += (long long)(a) * (long long)(b) * (long long)(c) * (long long)(d);
        return total;
    }
};