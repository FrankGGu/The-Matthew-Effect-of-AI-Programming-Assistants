public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> longestObstacleCourseAtEachPosition(int[] obstacles) {
        List<Integer> result = new ArrayList<>();
        List<Integer> tails = new ArrayList<>();

        for (int obstacle : obstacles) {
            int left = 0, right = tails.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (tails.get(mid) <= obstacle) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if (left == tails.size()) {
                tails.add(obstacle);
            } else {
                tails.set(left, obstacle);
            }
            result.add(left + 1);
        }

        return result;
    }
}
}