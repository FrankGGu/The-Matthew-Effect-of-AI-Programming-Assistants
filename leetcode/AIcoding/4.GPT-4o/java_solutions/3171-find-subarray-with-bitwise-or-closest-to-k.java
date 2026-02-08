import java.util.TreeMap;

public class Solution {
    public int[] closestSubarray(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[2];
        int minDiff = Integer.MAX_VALUE;
        int currentOr = 0;
        TreeMap<Integer, Integer> map = new TreeMap<>();

        for (int i = 0, j = 0; j < n; j++) {
            currentOr |= nums[j];
            while (currentOr > k && i <= j) {
                currentOr ^= nums[i++];
            }
            int diff = Math.abs(currentOr - k);
            if (diff < minDiff) {
                minDiff = diff;
                result[0] = i;
                result[1] = j;
            }
            map.put(currentOr, j);
        }

        return result;
    }
}