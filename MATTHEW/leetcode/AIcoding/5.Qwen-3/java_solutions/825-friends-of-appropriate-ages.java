public class Solution {

import java.util.*;

public class Solution {
    public int numFriendRequests(String s) {
        int[] count = new int[121];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int result = 0;
        for (int i = 0; i <= 120; i++) {
            if (count[i] == 0) continue;
            for (int j = 0; j <= 120; j++) {
                if (count[j] == 0) continue;
                if (i > j && j > 14) {
                    result += count[i] * count[j];
                } else if (i == j) {
                    result += count[i] * (count[i] - 1);
                }
            }
        }
        return result;
    }
}
}