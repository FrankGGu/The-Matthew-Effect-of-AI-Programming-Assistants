class Solution {
    public int numEquivDominoPairs(int[][] dominoes) {
        Map<Integer, Integer> count = new HashMap<>();
        int res = 0;
        for (int[] d : dominoes) {
            int key = Math.min(d[0], d[1]) * 10 + Math.max(d[0], d[1]);
            res += count.getOrDefault(key, 0);
            count.put(key, count.getOrDefault(key, 0) + 1);
        }
        return res;
    }
}