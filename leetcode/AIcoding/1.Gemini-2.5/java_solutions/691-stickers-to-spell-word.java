import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minStickers(String[] stickers, String target) {
        int n = target.length();
        // stickerCounts[i][j] stores the count of character 'a'+j in sticker i
        int[][] stickerCounts = new int[stickers.length][26];
        for (int i = 0; i < stickers.length; i++) {
            for (char c : stickers[i].toCharArray()) {
                stickerCounts[i][c - 'a']++;
            }
        }

        // Memoization map: mask -> min stickers needed
        // Integer.MAX_VALUE indicates not reachable, 0 indicates base case (mask is 0)
        Map<Integer, Integer> memo = new HashMap<>();
        memo.put(0, 0); // Base case: 0 stickers needed for an empty target (mask 0)

        // Start DFS from the full target mask
        // (1 << n) - 1 creates a mask with all 'n' bits set
        int result = dfs((1 << n) - 1, target, stickerCounts, memo);

        return result == Integer.MAX_VALUE ? -1 : result;
    }

    private int dfs(int mask, String target, int[][] stickerCounts, Map<Integer, Integer> memo) {
        if (memo.containsKey(mask)) {
            return memo.get(mask);
        }

        int res = Integer.MAX_VALUE;

        // Find the index of the first character in target that is still needed (represented by the mask)
        // This character will be our "anchor" for selecting relevant stickers.
        int firstCharIdxInTarget = -1;
        for (int i = 0; i < target.length(); i++) {
            if (((mask >> i) & 1) == 1) { // If i-th bit is set, character target.charAt(i) is needed
                firstCharIdxInTarget = i;
                break;
            }
        }

        // If no character is found, it means the mask is 0, which should already be handled by memo.put(0,0)
        // This check is a safeguard, but typically won't be reached if mask=0 is the base case.
        if (firstCharIdxInTarget == -1) {
            return 0;
        }

        char charToSpell = target.charAt(firstCharIdxInTarget);

        for (int[] sCount : stickerCounts) {
            // Optimization: If the current sticker doesn't have the first required character, skip it.
            // This prunes branches where a sticker cannot contribute to the most urgent character.
            if (sCount[charToSpell - 'a'] == 0) {
                continue;
            }

            int currentMask = mask;
            // Create a temporary copy of sticker character counts for this iteration to avoid modifying original
            int[] tempSCount = Arrays.copyOf(sCount, sCount.length);

            // Apply the current sticker to the current mask
            for (int i = 0; i < target.length(); i++) {
                if (((currentMask >> i) & 1) == 1) { // If i-th bit is set (char target.charAt(i) is needed)
                    char c = target.charAt(i);
                    if (tempSCount[c - 'a'] > 0) {
                        tempSCount[c - 'a']--;
                        currentMask &= ~(1 << i); // Unset the i-th bit, as this character is now covered
                    }
                }
            }

            // If the sticker actually helped (i.e., currentMask is smaller than the original mask)
            // This condition is implicitly true if we picked a sticker that has 'charToSpell'
            // and 'charToSpell' was part of the mask.
            if (currentMask < mask) {
                int subProblemResult = dfs(currentMask, target, stickerCounts, memo);
                if (subProblemResult != Integer.MAX_VALUE) { // If subproblem is solvable
                    res = Math.min(res, 1 + subProblemResult);
                }
            }
        }

        memo.put(mask, res);
        return res;
    }
}