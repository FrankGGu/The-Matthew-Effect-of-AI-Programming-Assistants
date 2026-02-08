import java.util.Arrays;

public class Solution {
    public int pickGifts(int[] gifts, int k) {
        int n = gifts.length;
        for (int i = 0; i < k; i++) {
            Arrays.sort(gifts);
            gifts[n - 1] = (int) Math.floor(Math.sqrt(gifts[n - 1]));
        }
        int sum = 0;
        for (int gift : gifts) {
            sum += gift;
        }
        return sum;
    }
}