class Solution {
    public int punishmentNumber(int n) {
        int punishmentNum = 0;
        for (int i = 1; i <= n; i++) {
            if (isPunishmentNumber(i)) {
                punishmentNum += i * i;
            }
        }
        return punishmentNum;
    }

    private boolean isPunishmentNumber(int num) {
        int square = num * num;
        return canFormSquare(square, 0);
    }

    private boolean canFormSquare(int square, int sum) {
        if (sum > square) return false;
        if (sum == square) return true;
        for (int i = 1; i <= square; i++) {
            if (canFormSquare(square, sum + i)) {
                return true;
            }
        }
        return false;
    }
}