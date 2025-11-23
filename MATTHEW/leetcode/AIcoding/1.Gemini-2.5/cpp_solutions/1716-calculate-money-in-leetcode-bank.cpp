class Solution {
public:
    int totalMoney(int n) {
        int k = n / 7;
        int r = n % 7;

        int total = k * 28;
        total += 7 * k * (k - 1) / 2;
        total += r * (r + 1) / 2 + r * k;

        return total;
    }
};