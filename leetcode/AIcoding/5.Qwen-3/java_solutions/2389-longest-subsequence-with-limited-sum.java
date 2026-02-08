public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        Arrays.sort(nums);
        for (int i = 1; i < nums.length; i++) {
            nums[i] += nums[i - 1];
        }
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int sum = 0;
            int count = 0;
            for (int j = 0; j < nums.length; j++) {
                if (sum + nums[j] <= queries[i]) {
                    sum += nums[j];
                    count++;
                } else {
                    break;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}