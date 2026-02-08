public class Solution {

import java.util.*;

public class Solution {
    public String longestDupSubstring(String s) {
        int n = s.length();
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = s.charAt(i) - 'a' + 1;
        }

        int base = 26;
        int mod = (int) Math.pow(2, 32);

        int left = 1, right = n - 1;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (search(mid, nums, base, mod, n) != -1) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        int start = search(ans, nums, base, mod, n);
        return s.substring(start, start + ans);
    }

    private int search(int length, int[] nums, int base, int mod, int n) {
        long hash = 0;
        for (int i = 0; i < length; i++) {
            hash = (hash * base + nums[i]) % mod;
        }

        Set<Long> seen = new HashSet<>();
        seen.add(hash);

        long baseL = 1;
        for (int i = 0; i < length; i++) {
            baseL = (baseL * base) % mod;
        }

        for (int i = length; i < n; i++) {
            hash = (hash * base - nums[i - length] * baseL + nums[i]) % mod;
            if (hash < 0) hash += mod;
            if (seen.contains(hash)) {
                return i - length + 1;
            }
            seen.add(hash);
        }

        return -1;
    }
}
}