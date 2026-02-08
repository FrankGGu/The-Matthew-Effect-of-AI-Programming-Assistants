class Solution {
public:
    int countDigitOne(int n) {
        if (n <= 0) return 0;
        long long base = 1;
        int totalOnes = 0;
        while (base <= n) {
            int high = n / (base * 10);
            int cur = (n / base) % 10;
            int low = n % base;
            if (cur == 0) {
                totalOnes += high * base;
            } else if (cur == 1) {
                totalOnes += high * base + low + 1;
            } else {
                totalOnes += (high + 1) * base;
            }
            base *= 10;
        }
        return totalOnes;
    }
};