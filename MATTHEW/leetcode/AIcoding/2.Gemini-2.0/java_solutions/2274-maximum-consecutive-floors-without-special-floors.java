import java.util.Arrays;

class Solution {
    public int maxConsecutive(int bottom, int top, int[] special) {
        Arrays.sort(special);
        int maxConsecutive = Math.max(special[0] - bottom, top - special[special.length - 1]);
        for (int i = 1; i < special.length; i++) {
            maxConsecutive = Math.max(maxConsecutive, special[i] - special[i - 1] - 1);
        }
        return maxConsecutive;
    }
}