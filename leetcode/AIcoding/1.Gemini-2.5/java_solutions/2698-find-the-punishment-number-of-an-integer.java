class Solution {
    public int punishmentNumber(int n) {
        int totalPunishmentSum = 0;
        for (int i = 1; i <= n; i++) {
            int square = i * i;
            String s = String.valueOf(square);
            if (canPartition(s, 0, 0, i)) {
                totalPunishmentSum += square;
            }
        }
        return totalPunishmentSum;
    }

    private boolean canPartition(String s, int index, int currentSum, int target) {
        if (currentSum > target) {
            return false;
        }
        if (index == s.length()) {
            return currentSum == target;
        }

        for (int i = index; i < s.length(); i++) {
            String sub = s.substring(index, i + 1);
            int num = Integer.parseInt(sub);
            if (canPartition(s, i + 1, currentSum + num, target)) {
                return true;
            }
        }
        return false;
    }
}