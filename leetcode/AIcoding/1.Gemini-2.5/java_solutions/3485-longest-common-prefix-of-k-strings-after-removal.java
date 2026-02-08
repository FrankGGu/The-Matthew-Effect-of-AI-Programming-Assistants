import java.util.HashMap;
import java.util.Map;

class Solution {
    public String longestCommonPrefix(String[] strs, int k) {
        if (strs == null || strs.length == 0 || k <= 0) {
            return "";
        }
        if (k > strs.length) {
            return "";
        }

        int maxPossibleLen = 0;
        for (String s : strs) {
            maxPossibleLen = Math.max(maxPossibleLen, s.length());
        }

        int low = 0;
        int high = maxPossibleLen;
        int ansLen = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (check(strs, k, mid)) {
                ansLen = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (ansLen == 0) {
            return "";
        }

        for (String s : strs) {
            if (s.length() >= ansLen) {
                String prefix = s.substring(0, ansLen);
                int count = 0;
                for (String otherS : strs) {
                    if (otherS.length() >= ansLen && otherS.startsWith(prefix)) {
                        count++;
                    }
                }
                if (count >= k) {
                    return prefix;
                }
            }
        }

        return ""; 
    }

    private boolean check(String[] strs, int k, int len) {
        if (len == 0) {
            return true;
        }

        Map<String, Integer> prefixCounts = new HashMap<>();
        for (String s : strs) {
            if (s.length() >= len) {
                String prefix = s.substring(0, len);
                prefixCounts.put(prefix, prefixCounts.getOrDefault(prefix, 0) + 1);
            }
        }

        for (int count : prefixCounts.values()) {
            if (count >= k) {
                return true;
            }
        }
        return false;
    }
}