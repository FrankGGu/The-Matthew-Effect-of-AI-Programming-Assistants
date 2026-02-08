import java.util.Arrays;

public class Solution {
    public int[] gcdSort(int[] nums, int[][] queries) {
        int n = nums.length;
        int[] sortedNums = nums.clone();
        Arrays.sort(sortedNums);

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            int[] subArray = Arrays.copyOfRange(nums, l, r + 1);
            Arrays.sort(subArray);
            boolean isSorted = true;
            for (int j = l; j <= r; j++) {
                if (subArray[j - l] != sortedNums[j]) {
                    isSorted = false;
                    break;
                }
            }
            result[i] = isSorted ? 1 : 0;
        }

        return result;
    }
}