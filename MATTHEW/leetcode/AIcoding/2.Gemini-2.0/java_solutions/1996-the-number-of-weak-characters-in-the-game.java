import java.util.Arrays;

class Solution {
    public int numberOfWeakCharacters(int[][] properties) {
        Arrays.sort(properties, (a, b) -> (a[0] == b[0]) ? (b[1] - a[1]) : (b[0] - a[0]));
        int weakCharacters = 0;
        int maxDefense = 0;
        for (int[] property : properties) {
            if (property[1] < maxDefense) {
                weakCharacters++;
            }
            maxDefense = Math.max(maxDefense, property[1]);
        }
        return weakCharacters;
    }
}