class Solution {
    public int maxEqualRowsAfterFlips(int[][] matrix) {
        Map<String, Integer> map = new HashMap<>();
        for (int[] row : matrix) {
            StringBuilder sb1 = new StringBuilder();
            StringBuilder sb2 = new StringBuilder();
            for (int num : row) {
                sb1.append(num);
                sb2.append(1 - num);
            }
            String key1 = sb1.toString();
            String key2 = sb2.toString();
            map.put(key1, map.getOrDefault(key1, 0) + 1);
            map.put(key2, map.getOrDefault(key2, 0) + 1);
        }
        int max = 0;
        for (int count : map.values()) {
            max = Math.max(max, count);
        }
        return max;
    }
}