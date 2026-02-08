import java.util.Arrays;

public class Solution {
    public boolean makesquare(int[] matchsticks) {
        int totalLength = Arrays.stream(matchsticks).sum();
        if (totalLength % 4 != 0) return false;
        int sideLength = totalLength / 4;
        Arrays.sort(matchsticks);
        reverse(matchsticks);
        return backtrack(matchsticks, new int[4], 0, sideLength);
    }

    private boolean backtrack(int[] matchsticks, int[] sides, int index, int sideLength) {
        if (index == matchsticks.length) {
            return sides[0] == sideLength && sides[1] == sideLength && sides[2] == sideLength && sides[3] == sideLength;
        }
        for (int i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= sideLength) {
                sides[i] += matchsticks[index];
                if (backtrack(matchsticks, sides, index + 1, sideLength)) return true;
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    }

    private void reverse(int[] matchsticks) {
        for (int i = 0; i < matchsticks.length / 2; i++) {
            int temp = matchsticks[i];
            matchsticks[i] = matchsticks[matchsticks.length - 1 - i];
            matchsticks[matchsticks.length - 1 - i] = temp;
        }
    }
}