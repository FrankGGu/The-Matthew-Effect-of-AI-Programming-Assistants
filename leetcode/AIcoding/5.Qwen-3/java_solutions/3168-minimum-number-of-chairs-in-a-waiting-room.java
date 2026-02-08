public class Solution {

import java.util.*;

public class Solution {
    public int minInteger(int num, int[] move) {
        String s = String.valueOf(num);
        char[] chars = s.toCharArray();
        int n = chars.length;
        int[] positions = new int[n];
        for (int i = 0; i < n; i++) {
            positions[i] = i;
        }
        Arrays.sort(positions, (a, b) -> chars[a] - chars[b]);
        int[] moveCount = new int[n];
        for (int i = 0; i < n; i++) {
            moveCount[i] = move[positions[i]];
        }
        int res = 0;
        int[] chairs = new int[n];
        for (int i = 0; i < n; i++) {
            int pos = positions[i];
            int count = moveCount[i];
            if (count == 0) {
                continue;
            }
            int j = pos + 1;
            while (j < n && chars[j] == chars[pos]) {
                j++;
            }
            int k = j - 1;
            while (count > 0 && k >= 0) {
                if (chars[k] == chars[pos] && k != pos) {
                    chairs[k]++;
                    count--;
                }
                k--;
            }
            if (count > 0) {
                return -1;
            }
        }
        for (int c : chairs) {
            res = Math.max(res, c);
        }
        return res;
    }
}
}