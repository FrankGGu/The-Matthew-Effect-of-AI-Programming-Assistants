public class Solution {

import java.util.*;

public class Solution {
    public int[] distributeCandies(int candies, int numChildren) {
        int[] result = new int[numChildren];
        int each = candies / numChildren;
        int remainder = candies % numChildren;

        for (int i = 0; i < numChildren; i++) {
            result[i] = each;
        }

        for (int i = 0; i < remainder; i++) {
            result[i]++;
        }

        return result;
    }
}
}