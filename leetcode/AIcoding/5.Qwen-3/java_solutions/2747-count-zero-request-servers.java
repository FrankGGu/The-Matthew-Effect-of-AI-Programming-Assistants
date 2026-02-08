public class Solution {

import java.util.*;

public class Solution {
    public int[] countZeroRequests(int[][] requests, int k) {
        int n = requests.length;
        int[] result = new int[k];

        for (int i = 0; i < n; i++) {
            int server = requests[i][0];
            int time = requests[i][1];
            int count = 0;

            for (int j = 0; j < k; j++) {
                if (time >= j * 100 && time < (j + 1) * 100) {
                    count++;
                }
            }

            result[server] += count;
        }

        return result;
    }
}
}