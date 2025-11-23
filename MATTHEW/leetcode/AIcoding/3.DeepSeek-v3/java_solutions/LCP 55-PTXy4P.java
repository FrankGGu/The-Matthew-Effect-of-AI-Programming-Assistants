class Solution {
    public int getMinimumTime(int[] time, int[][] fruits, int limit) {
        int totalTime = 0;
        for (int[] fruit : fruits) {
            int type = fruit[0];
            int num = fruit[1];
            int batches = (num + limit - 1) / limit;
            totalTime += batches * time[type];
        }
        return totalTime;
    }
}