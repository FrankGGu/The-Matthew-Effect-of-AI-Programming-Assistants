public class Solution {

import java.util.*;

public class Solution {
    public int maximumDeletions(String s) {
        int n = s.length();
        List<Integer> dp = new ArrayList<>();
        List<Character> tails = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int left = 0, right = tails.size() - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (tails.get(mid) < s.charAt(i)) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (left == tails.size()) {
                tails.add(s.charAt(i));
                dp.add(1);
            } else {
                tails.set(left, s.charAt(i));
                dp.add(dp.get(left) + 1);
            }
        }

        return Collections.max(dp);
    }
}
}