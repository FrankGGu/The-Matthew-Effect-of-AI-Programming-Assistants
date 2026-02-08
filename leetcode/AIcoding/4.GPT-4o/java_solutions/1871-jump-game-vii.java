class Solution {
    public boolean canReach(String s, int minJump, int maxJump) {
        int n = s.length();
        if (s.charAt(0) == '1' || s.charAt(n - 1) == '1') return false;

        int maxReach = 0;
        for (int i = 0; i < n; i++) {
            if (i > maxReach) return false;
            if (s.charAt(i) == '0') {
                if (i >= minJump) {
                    maxReach = Math.max(maxReach, i + maxJump);
                }
            }
        }
        return maxReach >= n - 1;
    }
}