public class Solution {

import java.util.*;

public class Solution {
    public int minimumSecondsToMakeMountainZero(int[] a) {
        int n = a.length;
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(left, -1);
        Arrays.fill(right, -1);

        for (int i = 1; i < n; i++) {
            if (a[i] > a[i - 1]) {
                left[i] = left[i - 1];
            } else {
                left[i] = i - 1;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (a[i] > a[i + 1]) {
                right[i] = right[i + 1];
            } else {
                right[i] = i + 1;
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            int l = left[i];
            int r = right[i];
            if (l == -1 && r == -1) {
                result = Math.max(result, a[i]);
            } else if (l == -1) {
                result = Math.max(result, (a[i] + r - i) / 1);
            } else if (r == -1) {
                result = Math.max(result, (a[i] + i - l) / 1);
            } else {
                int time = Math.max(a[i] - a[l], a[i] - a[r]);
                result = Math.max(result, time);
            }
        }

        return result;
    }
}
}