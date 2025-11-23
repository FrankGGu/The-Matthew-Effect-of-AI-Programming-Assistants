import java.util.Arrays;

class Solution {
    public int expectNumber(int[] scores) {
        Arrays.sort(scores);
        int count = 0;
        for (int i = 0; i < scores.length; i++) {
            if (i == 0 || scores[i] != scores[i - 1]) {
                count++;
            }
        }
        return count;
    }
}