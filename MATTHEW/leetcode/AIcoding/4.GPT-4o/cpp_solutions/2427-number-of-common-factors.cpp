class Solution {
public:
    int commonFactors(int a, int b) {
        int gcd = std::__gcd(a, b);
        int count = 0;
        for (int i = 1; i * i <= gcd; ++i) {
            if (gcd % i == 0) {
                count++;
                if (i != gcd / i) count++;
            }
        }
        return count;
    }
};