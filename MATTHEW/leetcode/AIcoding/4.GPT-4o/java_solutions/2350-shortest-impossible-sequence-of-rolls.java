import java.util.HashSet;

public class Solution {
    public int shortestSequence(int[] rolls, int k) {
        HashSet<Integer> uniqueRolls = new HashSet<>();
        int n = rolls.length;
        int minLength = 1;

        for (int i = 0; i < n; i++) {
            uniqueRolls.add(rolls[i]);
            if (uniqueRolls.size() == k) {
                return minLength;
            }
            if (i == n - 1) {
                minLength++;
                uniqueRolls.clear();
                i = -1;
            }
        }

        return minLength;
    }
}