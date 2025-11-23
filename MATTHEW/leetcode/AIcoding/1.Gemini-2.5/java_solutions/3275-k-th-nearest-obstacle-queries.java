import java.util.Arrays;

class Solution {
    public int[] answerQueries(int[] obstacles, int[] queries) {
        Arrays.sort(obstacles);

        for (int i = 1; i < obstacles.length; i++) {
            obstacles[i] += obstacles[i - 1];
        }

        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int queryMaxHeight = queries[i];
            ans[i] = upper_bound(obstacles, queryMaxHeight);
        }

        return ans;
    }

    private int upper_bound(int[] arr, int target) {
        int low = 0;
        int high = arr.length;

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}