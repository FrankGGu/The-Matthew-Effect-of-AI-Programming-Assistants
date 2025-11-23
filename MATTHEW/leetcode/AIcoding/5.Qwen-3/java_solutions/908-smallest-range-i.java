public class Solution {

import java.util.Arrays;

public class Solution {
    public int smallestRangeI(int[] nums, int k) {
        int min = Arrays.stream(nums).min().getAsInt();
        int max = Arrays.stream(nums).max().getAsInt();
        return Math.max(0, max - min - 2 * k);
    }
}
}