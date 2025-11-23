class Solution {
    public int minimumSwitchingTimes(int[][] source, int[][] target) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int[] row : source) {
            for (int color : row) {
                freq.put(color, freq.getOrDefault(color, 0) + 1);
            }
        }
        for (int[] row : target) {
            for (int color : row) {
                freq.put(color, freq.getOrDefault(color, 0) - 1);
            }
        }
        int res = 0;
        for (int count : freq.values()) {
            res += Math.abs(count);
        }
        return res / 2;
    }
}