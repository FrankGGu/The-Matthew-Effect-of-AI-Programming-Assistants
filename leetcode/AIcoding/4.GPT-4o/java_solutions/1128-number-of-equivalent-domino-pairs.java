import java.util.HashMap;

public class Solution {
    public int numEquivDominoPairs(int[][] dominoes) {
        HashMap<Integer, Integer> count = new HashMap<>();
        int result = 0;

        for (int[] domino : dominoes) {
            int key = Math.min(domino[0], domino[1]) * 10 + Math.max(domino[0], domino[1]);
            count.put(key, count.getOrDefault(key, 0) + 1);
        }

        for (int value : count.values()) {
            result += value * (value - 1) / 2;
        }

        return result;
    }
}