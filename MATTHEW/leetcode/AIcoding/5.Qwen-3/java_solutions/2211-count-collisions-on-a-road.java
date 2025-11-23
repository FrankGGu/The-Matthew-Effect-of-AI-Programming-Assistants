public class Solution {

import java.util.*;

public class Solution {
    public int countCollisions(String directions) {
        int n = directions.length();
        int left = 0;
        int right = n - 1;

        while (left <= right && directions.charAt(left) == 'L') {
            left++;
        }

        while (right >= left && directions.charAt(right) == 'R') {
            right--;
        }

        int count = 0;
        for (int i = left; i <= right; i++) {
            if (directions.charAt(i) == 'S' || (i > 0 && directions.charAt(i - 1) == 'R' && directions.charAt(i) == 'L')) {
                count++;
            }
        }

        return count;
    }
}
}