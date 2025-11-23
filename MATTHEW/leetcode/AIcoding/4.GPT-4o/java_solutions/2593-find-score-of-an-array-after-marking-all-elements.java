import java.util.Arrays;

public class Solution {
    public long findScore(int[] nums) {
        boolean[] marked = new boolean[nums.length];
        long score = 0;

        Integer[] indices = new Integer[nums.length];
        for (int i = 0; i < nums.length; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> Integer.compare(nums[a], nums[b]));

        for (int index : indices) {
            if (!marked[index]) {
                score += nums[index];
                marked[index] = true;
                if (index > 0) marked[index - 1] = true;
                if (index < nums.length - 1) marked[index + 1] = true;
            }
        }

        return score;
    }
}