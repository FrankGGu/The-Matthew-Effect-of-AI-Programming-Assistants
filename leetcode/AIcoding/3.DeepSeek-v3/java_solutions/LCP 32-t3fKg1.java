import java.util.Arrays;

class Solution {
    public int minimumEffort(int[][] tasks) {
        Arrays.sort(tasks, (a, b) -> (b[1] - b[0]) - (a[1] - a[0]));
        int res = 0;
        int sum = 0;
        for (int[] task : tasks) {
            res = Math.max(res, sum + task[1]);
            sum += task[0];
        }
        return res;
    }
}