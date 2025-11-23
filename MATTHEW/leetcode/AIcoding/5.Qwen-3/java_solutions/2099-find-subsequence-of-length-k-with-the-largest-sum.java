public class Solution {

import java.util.*;

public class Solution {
    public int[] maxSubsequence(int[] nums, int k) {
        int n = nums.length;
        int[][] indexedNums = new int[n][2];

        for (int i = 0; i < n; i++) {
            indexedNums[i][0] = nums[i];
            indexedNums[i][1] = i;
        }

        Arrays.sort(indexedNums, (a, b) -> b[0] - a[0]);

        int[] result = new int[k];
        int[] indices = new int[k];

        for (int i = 0; i < k; i++) {
            result[i] = indexedNums[i][0];
            indices[i] = indexedNums[i][1];
        }

        Arrays.sort(indices);

        int[] answer = new int[k];
        for (int i = 0; i < k; i++) {
            answer[i] = result[i];
        }

        return answer;
    }
}
}