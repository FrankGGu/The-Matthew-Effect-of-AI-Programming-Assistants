class Solution {
    public int punishmentNumber(int n) {
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            int square = i * i;
            if (canSplit(String.valueOf(square), i)) {
                sum += square;
            }
        }
        return sum;
    }

    private boolean canSplit(String s, int target) {
        if (s.isEmpty() && target == 0) {
            return true;
        }
        for (int i = 1; i <= s.length(); i++) {
            String part = s.substring(0, i);
            int num = Integer.parseInt(part);
            if (num > target) {
                break;
            }
            if (canSplit(s.substring(i), target - num)) {
                return true;
            }
        }
        return false;
    }
}