public class Solution {

import java.util.*;

public class Solution {
    public int distributeCandies(int n, int k) {
        int[] candies = new int[k];
        int index = 0;
        while (n > 0) {
            candies[index] += Math.min(n, index + 1);
            n -= Math.min(n, index + 1);
            index = (index + 1) % k;
        }
        return candies[0];
    }
}
}