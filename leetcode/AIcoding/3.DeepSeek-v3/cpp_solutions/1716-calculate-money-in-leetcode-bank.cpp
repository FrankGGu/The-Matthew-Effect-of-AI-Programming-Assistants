class Solution {
public:
    int totalMoney(int n) {
        int weeks = n / 7;
        int days = n % 7;
        int total = weeks * 28 + 7 * weeks * (weeks - 1) / 2;
        total += days * (weeks + 1 + weeks + days) / 2;
        return total;
    }
};