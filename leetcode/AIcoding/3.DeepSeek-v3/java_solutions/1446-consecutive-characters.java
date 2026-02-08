class Solution {
    public int maxPower(String s) {
        int max = 1;
        int current = 1;
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                current++;
                max = Math.max(max, current);
            } else {
                current = 1;
            }
        }
        return max;
    }
}