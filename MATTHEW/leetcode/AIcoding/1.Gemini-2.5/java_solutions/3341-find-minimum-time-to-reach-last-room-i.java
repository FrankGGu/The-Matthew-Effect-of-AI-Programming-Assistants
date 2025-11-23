class Solution {
    public long findMinimumTime(int[][] rooms) {
        long currentTime = 0;
        for (int i = 0; i < rooms.length; i++) {
            int arrivalTime = rooms[i][0];
            int duration = rooms[i][1];
            long actualEnterTime = Math.max(currentTime, (long)arrivalTime);
            currentTime = actualEnterTime + duration;
        }
        return currentTime;
    }
}