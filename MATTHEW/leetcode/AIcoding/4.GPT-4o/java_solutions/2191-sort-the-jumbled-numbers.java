import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int[] sortJumbled(int[] mapping, int[] nums) {
        Integer[] indices = new Integer[nums.length];
        for (int i = 0; i < nums.length; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, Comparator.comparingInt(i -> mapNumber(nums[i], mapping)));

        int[] result = new int[nums.length];
        for (int i = 0; i < indices.length; i++) {
            result[i] = nums[indices[i]];
        }

        return result;
    }

    private int mapNumber(int num, int[] mapping) {
        StringBuilder sb = new StringBuilder();
        if (num == 0) {
            return mapping[0];
        }
        while (num > 0) {
            sb.append(mapping[num % 10]);
            num /= 10;
        }
        return Integer.parseInt(sb.reverse().toString());
    }
}