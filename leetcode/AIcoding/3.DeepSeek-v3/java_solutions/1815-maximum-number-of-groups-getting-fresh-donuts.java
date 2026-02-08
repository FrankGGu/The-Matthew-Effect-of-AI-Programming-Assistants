class Solution {
    private Map<String, Integer> memo = new HashMap<>();

    public int maxHappyGroups(int batchSize, int[] groups) {
        int[] count = new int[batchSize];
        for (int g : groups) {
            count[g % batchSize]++;
        }
        int res = count[0];
        for (int i = 1; i <= batchSize / 2; i++) {
            int j = batchSize - i;
            if (i == j) {
                res += count[i] / 2;
                count[i] %= 2;
            } else {
                int min = Math.min(count[i], count[j]);
                res += min;
                count[i] -= min;
                count[j] -= min;
            }
        }
        res += dfs(count, 0, batchSize);
        return res;
    }

    private int dfs(int[] count, int sum, int batchSize) {
        String key = Arrays.toString(count);
        if (memo.containsKey(key)) {
            return memo.get(key);
        }
        int res = 0;
        for (int i = 1; i < batchSize; i++) {
            if (count[i] == 0) continue;
            count[i]--;
            int happy = (sum == 0) ? 1 : 0;
            int cur = happy + dfs(count, (sum + i) % batchSize, batchSize);
            res = Math.max(res, cur);
            count[i]++;
        }
        memo.put(key, res);
        return res;
    }
}