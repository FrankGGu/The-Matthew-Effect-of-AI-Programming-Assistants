public class Solution {

import java.util.*;

public class Solution {
    public int overlap(int[][] img1, int[][] img2) {
        int n = img1.length;
        Set<String> set1 = new HashSet<>();
        Set<String> set2 = new HashSet<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (img1[i][j] == 1) {
                    set1.add(i + "," + j);
                }
                if (img2[i][j] == 1) {
                    set2.add(i + "," + j);
                }
            }
        }

        int maxOverlap = 0;
        for (String s : set1) {
            String[] parts = s.split(",");
            int x1 = Integer.parseInt(parts[0]);
            int y1 = Integer.parseInt(parts[1]);
            for (String t : set2) {
                String[] parts2 = t.split(",");
                int x2 = Integer.parseInt(parts2[0]);
                int y2 = Integer.parseInt(parts2[1]);
                int dx = x1 - x2;
                int dy = y1 - y2;
                int count = 0;
                for (String s1 : set1) {
                    String[] parts3 = s1.split(",");
                    int x = Integer.parseInt(parts3[0]);
                    int y = Integer.parseInt(parts3[1]);
                    if (set2.contains((x - dx) + "," + (y - dy))) {
                        count++;
                    }
                }
                maxOverlap = Math.max(maxOverlap, count);
            }
        }

        return maxOverlap;
    }
}
}