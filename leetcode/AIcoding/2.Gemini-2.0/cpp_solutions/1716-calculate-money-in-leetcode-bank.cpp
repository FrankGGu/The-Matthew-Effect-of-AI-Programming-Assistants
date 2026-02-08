class Solution {
public:
    int totalMoney(int n) {
        int weeks = n / 7;
        int days = n % 7;
        int total = 0;
        total += weeks * 28;
        total += weeks * (weeks - 1) / 2 * 7;
        total += (weeks + 1 + weeks + days) * days / 2;
        return total;
    }
};