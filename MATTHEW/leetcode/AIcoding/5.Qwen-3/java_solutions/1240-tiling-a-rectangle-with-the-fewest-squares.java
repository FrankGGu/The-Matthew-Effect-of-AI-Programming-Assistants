public class Solution {

import java.util.*;

public class Solution {
    public int tilingArea(int n, int m) {
        if (n > m) {
            return tilingArea(m, n);
        }
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return m;
        }
        int min = Integer.MAX_VALUE;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                if (i * j == n * m) {
                    min = Math.min(min, 1);
                } else {
                    int a = i;
                    int b = j;
                    int c = n - i;
                    int d = m - j;
                    if (a > 0 && b > 0) {
                        min = Math.min(min, tilingArea(a, b) + tilingArea(c, m) + tilingArea(n, d));
                    }
                    if (a > 0 && d > 0) {
                        min = Math.min(min, tilingArea(a, d) + tilingArea(c, m) + tilingArea(n, b));
                    }
                    if (b > 0 && c > 0) {
                        min = Math.min(min, tilingArea(b, c) + tilingArea(n, d) + tilingArea(a, m));
                    }
                    if (d > 0 && c > 0) {
                        min = Math.min(min, tilingArea(d, c) + tilingArea(n, b) + tilingArea(a, m));
                    }
                }
            }
        }
        return min;
    }

    public int tilingRectangle(int n, int m) {
        return tilingArea(n, m);
    }
}
}