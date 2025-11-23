public class Solution {
    public int punishmentNumber(int n) {
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (isValid(i)) {
                sum += i * i;
            }
        }
        return sum;
    }

    private boolean isValid(int num) {
        String s = String.valueOf(num);
        return helper(s, num);
    }

    private boolean helper(String s, int target) {
        if (target == 0) {
            return true;
        }
        for (int i = 1; i <= s.length(); i++) {
            int current = Integer.parseInt(s.substring(0, i));
            if (current > target) {
                break;
            }
            if (helper(s.substring(i), target - current)) {
                return true;
            }
        }
        return false;
    }
}