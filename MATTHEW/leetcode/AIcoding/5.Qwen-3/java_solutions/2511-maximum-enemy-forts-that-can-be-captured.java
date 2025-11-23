public class Solution {

import java.util.*;

public class Solution {
    public int captureForts = 0;

    public int captureForts(int[] forts) {
        int n = forts.length;
        for (int i = 0; i < n; i++) {
            if (forts[i] == 1) {
                int left = i - 1;
                while (left >= 0 && forts[left] == 0) {
                    left--;
                }
                if (left >= 0 && forts[left] == -1) {
                    captureForts++;
                }

                int right = i + 1;
                while (right < n && forts[right] == 0) {
                    right++;
                }
                if (right < n && forts[right] == -1) {
                    captureForts++;
                }
            }
        }
        return captureForts;
    }
}
}