import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int hardestWorker(int n, int[][] logs) {
        int maxId = logs[0][0];
        int maxTime = logs[0][1];
        int prevTime = 0;

        for (int i = 0; i < logs.length; i++) {
            int id = logs[i][0];
            int time = logs[i][1] - prevTime;
            if (time > maxTime || (time == maxTime && id < maxId)) {
                maxTime = time;
                maxId = id;
            }
            prevTime = logs[i][1];
        }

        return maxId;
    }
}