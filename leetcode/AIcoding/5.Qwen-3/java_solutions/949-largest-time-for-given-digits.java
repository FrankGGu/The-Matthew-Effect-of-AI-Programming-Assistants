public class Solution {

import java.util.*;

public class Solution {
    public String largestTimeFromDigits(int[] arr) {
        int maxTime = -1;
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (j == i) continue;
                for (int k = 0; k < 4; k++) {
                    if (k == i || k == j) continue;
                    int l = 6 - i - j - k;
                    int hour = arr[i] * 10 + arr[j];
                    int minute = arr[k] * 10 + arr[l];
                    if (hour < 24 && minute < 60) {
                        maxTime = Math.max(maxTime, hour * 60 + minute);
                    }
                }
            }
        }
        if (maxTime == -1) return "";
        int hour = maxTime / 60;
        int minute = maxTime % 60;
        return String.format("%02d:%02d", hour, minute);
    }
}
}