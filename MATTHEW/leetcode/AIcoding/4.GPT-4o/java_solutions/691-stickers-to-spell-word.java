import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minStickers(String[] stickers, String target) {
        Map<Character, Integer> targetCount = new HashMap<>();
        for (char c : target.toCharArray()) {
            targetCount.put(c, targetCount.getOrDefault(c, 0) + 1);
        }
        int[][] stickerCounts = new int[stickers.length][26];
        for (int i = 0; i < stickers.length; i++) {
            for (char c : stickers[i].toCharArray()) {
                stickerCounts[i][c - 'a']++;
            }
        }
        return dfs(stickerCounts, targetCount);
    }

    private int dfs(int[][] stickerCounts, Map<Character, Integer> targetCount) {
        if (targetCount.isEmpty()) {
            return 0;
        }
        int res = Integer.MAX_VALUE;
        for (int[] sticker : stickerCounts) {
            Map<Character, Integer> newTargetCount = new HashMap<>(targetCount);
            for (int j = 0; j < 26; j++) {
                if (sticker[j] > 0 && newTargetCount.containsKey((char) (j + 'a'))) {
                    int count = Math.min(sticker[j], newTargetCount.get((char) (j + 'a')));
                    newTargetCount.put((char) (j + 'a'), newTargetCount.get((char) (j + 'a')) - count);
                    if (newTargetCount.get((char) (j + 'a')) == 0) {
                        newTargetCount.remove((char) (j + 'a'));
                    }
                }
            }
            if (!newTargetCount.equals(targetCount)) {
                int subResult = dfs(stickerCounts, newTargetCount);
                if (subResult != -1) {
                    res = Math.min(res, subResult + 1);
                }
            }
        }
        return res == Integer.MAX_VALUE ? -1 : res;
    }
}