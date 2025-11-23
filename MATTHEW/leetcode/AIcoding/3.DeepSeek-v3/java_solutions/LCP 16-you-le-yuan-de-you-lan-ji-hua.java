class Solution {
    public int maxHappyGroups(int batchSize, int[] groups) {
        int[] freq = new int[batchSize];
        for (int g : groups) {
            freq[g % batchSize]++;
        }
        int res = freq[0];
        freq[0] = 0;
        for (int i = 1; i <= batchSize / 2; i++) {
            int j = batchSize - i;
            if (i == j) {
                res += freq[i] / 2;
                freq[i] %= 2;
            } else {
                int min = Math.min(freq[i], freq[j]);
                res += min;
                freq[i] -= min;
                freq[j] -= min;
            }
        }
        int state = 0;
        for (int i = 1; i < batchSize; i++) {
            state |= freq[i] << (i * 5);
        }
        return res + dfs(batchSize, state, 0, new HashMap<>());
    }

    private int dfs(int batchSize, int state, int mod, Map<Integer, Integer> memo) {
        if (memo.containsKey(state)) {
            return memo.get(state);
        }
        int res = 0;
        for (int i = 1; i < batchSize; i++) {
            if ((state >> (i * 5)) % 32 > 0) {
                int newState = state - (1 << (i * 5));
                int newMod = (mod + i) % batchSize;
                int cur = dfs(batchSize, newState, newMod, memo);
                if (newMod == 0) {
                    cur++;
                }
                if (cur > res) {
                    res = cur;
                }
            }
        }
        memo.put(state, res);
        return res;
    }
}