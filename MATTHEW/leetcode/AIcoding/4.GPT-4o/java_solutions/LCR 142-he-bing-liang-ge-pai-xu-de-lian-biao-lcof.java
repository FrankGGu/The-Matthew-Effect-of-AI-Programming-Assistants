class Solution {
    public boolean canComplete(int[][] tasks, int strength) {
        int n = tasks.length;
        Arrays.sort(tasks, (a, b) -> Integer.compare(a[0], b[0]));

        for (int i = 0; i < n; i++) {
            if (strength < tasks[i][0]) return false;
            strength += tasks[i][1];
        }
        return true;
    }
}