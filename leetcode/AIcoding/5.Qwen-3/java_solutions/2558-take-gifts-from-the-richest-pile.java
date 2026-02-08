public class Solution {

import java.util.Arrays;

public class Solution {
    public int pickGifts(int[] gifts, int k) {
        for (int i = 0; i < k; i++) {
            int max = Arrays.stream(gifts).max().getAsInt();
            int index = -1;
            for (int j = 0; j < gifts.length; j++) {
                if (gifts[j] == max) {
                    index = j;
                    break;
                }
            }
            gifts[index] = (int) Math.sqrt(gifts[index]);
        }
        return Arrays.stream(gifts).sum();
    }
}
}