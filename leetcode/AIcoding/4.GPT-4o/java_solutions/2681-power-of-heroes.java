class Solution {
    public int maximalHeroPower(int[] power) {
        int n = power.length;
        int maxPower = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                maxPower = Math.max(maxPower, power[i] + power[j]);
            }
        }
        return maxPower;
    }
}