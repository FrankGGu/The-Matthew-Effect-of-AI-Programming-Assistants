class Solution {
    public int punishmentNumber(int n) {
        int ans = 0;
        for (int i = 1; i <= n; i++) {
            int sq = i * i;
            String s = String.valueOf(sq);
            if (isValid(s, 0, 0, i)) {
                ans += sq;
            }
        }
        return ans;
    }

    private boolean isValid(String s, int index, int sum, int target) {
        if (index == s.length()) {
            return sum == target;
        }

        for (int i = index; i < s.length(); i++) {
            int num = Integer.parseInt(s.substring(index, i + 1));
            if (isValid(s, i + 1, sum + num, target)) {
                return true;
            }
        }
        return false;
    }
}