public class Solution {

import java.util.*;

public class Solution {
    public int[] corpFlightBookings(int[][] bookings, int n) {
        int[] res = new int[n];
        for (int[] booking : bookings) {
            int start = booking[0] - 1;
            int end = booking[1] - 1;
            int val = booking[2];
            res[start] += val;
            if (end + 1 < n) {
                res[end + 1] -= val;
            }
        }
        for (int i = 1; i < n; i++) {
            res[i] += res[i - 1];
        }
        return res;
    }
}
}