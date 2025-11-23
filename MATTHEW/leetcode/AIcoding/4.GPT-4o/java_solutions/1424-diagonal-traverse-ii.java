import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int[] findDiagonalOrder(int[][] nums) {
        List<Integer> result = new ArrayList<>();
        int maxLength = 0;

        for (int[] row : nums) {
            maxLength = Math.max(maxLength, row.length);
        }

        for (int d = 0; d < maxLength; d++) {
            for (int i = 0; i < nums.length; i++) {
                if (d < nums[i].length) {
                    result.add(nums[i][d]);
                }
            }
        }

        int[] output = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            output[i] = result.get(result.size() - 1 - i);
        }

        return output;
    }
}