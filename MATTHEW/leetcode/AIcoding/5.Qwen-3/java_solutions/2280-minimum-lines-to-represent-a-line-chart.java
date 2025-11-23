public class Solution {

import java.util.*;

public class Solution {
    public int minimumLines(int[][] coordinates) {
        if (coordinates.length <= 1) {
            return 0;
        }
        Set<String> slopes = new HashSet<>();
        for (int i = 1; i < coordinates.length; i++) {
            int x1 = coordinates[i - 1][0];
            int y1 = coordinates[i - 1][1];
            int x2 = coordinates[i][0];
            int y2 = coordinates[i][1];
            int dx = x2 - x1;
            int dy = y2 - y1;
            int gcd = gcd(dx, dy);
            dx /= gcd;
            dy /= gcd;
            String slope = dx + "," + dy;
            slopes.add(slope);
        }
        return slopes.size();
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}