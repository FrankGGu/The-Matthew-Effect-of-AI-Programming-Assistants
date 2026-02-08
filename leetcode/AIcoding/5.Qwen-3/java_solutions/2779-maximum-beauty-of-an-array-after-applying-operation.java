public class Solution {

import java.util.*;

public class Solution {
    public int maximumBeauty(int[] nums, int k) {
        List<int[]> events = new ArrayList<>();

        for (int num : nums) {
            events.add(new int[]{num - k, 1});
            events.add(new int[]{num + k + 1, -1});
        }

        Collections.sort(events, (a, b) -> a[0] - b[0]);

        int maxBeauty = 0, current = 0;

        for (int[] event : events) {
            current += event[1];
            maxBeauty = Math.max(maxBeauty, current);
        }

        return maxBeauty;
    }
}
}