class Solution {
    public int maxPower(String s) {
        int maxPower = 1, currentPower = 1;
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i - 1)) {
                currentPower++;
            } else {
                maxPower = Math.max(maxPower, currentPower);
                currentPower = 1;
            }
        }
        return Math.max(maxPower, currentPower);
    }
}