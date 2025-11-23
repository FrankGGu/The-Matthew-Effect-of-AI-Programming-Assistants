public class Solution {

import java.util.Arrays;

public class Solution {
    public int buyCandies(int[] candies, int discount) {
        Arrays.sort(candies);
        int total = 0;
        for (int i = 0; i < candies.length; i++) {
            if (i % 2 == 1) {
                total += (int) (candies[i] * (1.0 - discount / 100.0));
            } else {
                total += candies[i];
            }
        }
        return total;
    }
}
}