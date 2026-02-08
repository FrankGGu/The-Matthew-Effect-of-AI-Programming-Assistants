public class Solution {

import java.util.*;

public class Solution {
    public int minStickers(int[] target, int[] stickers) {
        Map<String, Integer> memo = new HashMap<>();
        return dfs(target, stickers, memo);
    }

    private int dfs(int[] target, int[] stickers, Map<String, Integer> memo) {
        String key = Arrays.toString(target);
        if (memo.containsKey(key)) {
            return memo.get(key);
        }
        if (isZero(target)) {
            return 0;
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i < stickers.length; i++) {
            if (target[stickers[i]] == 0) {
                continue;
            }
            int[] newTarget = Arrays.copyOf(target, target.length);
            for (int j = 0; j < stickers.length; j++) {
                if (newTarget[stickers[j]] > 0) {
                    newTarget[stickers[j]]--;
                }
            }
            int next = dfs(newTarget, stickers, memo);
            if (next != -1) {
                res = Math.min(res, 1 + next);
            }
        }
        memo.put(key, res == Integer.MAX_VALUE ? -1 : res);
        return memo.get(key);
    }

    private boolean isZero(int[] target) {
        for (int count : target) {
            if (count > 0) {
                return false;
            }
        }
        return true;
    }
}
}