class Solution {
    public long makeDeposit(int n) {
        long totalMoney = 0;
        for (int i = 1; i <= n; i++) {
            totalMoney += (i + 1) * 10;
        }
        return totalMoney;
    }
}