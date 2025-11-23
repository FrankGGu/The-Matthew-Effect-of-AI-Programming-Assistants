public class Solution {
    public int busyStudent(int[] startTime, int[] endTime, int qTime) {
        int count = 0;
        for (int i = 0; i < startTime.length; i++) {
            if (startTime[i] <= qTime && endTime[i] >= qTime) {
                count++;
            }
        }
        return count;
    }
}