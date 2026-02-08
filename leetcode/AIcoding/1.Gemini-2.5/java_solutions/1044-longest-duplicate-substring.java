import java.util.HashMap;
import java.util.Map;

class Solution {

    private long base1 = 31;
    private long mod1 = 1_000_000_007;

    private long base2 = 37;
    private long mod2 = 1_000_000_009;

    private int[] nums;
    private int N;

    private long[] powers1;
    private long[] powers2;

    private int check(int len) {
        if (len == 0) return 0;

        long currentHash1 = 0;
        long currentHash2 = 0;
        for (int i = 0; i < len; i++) {
            currentHash1 = (currentHash1 * base1 + nums[i]) % mod1;
            currentHash2 = (currentHash2 * base2 + nums[i]) % mod2;
        }

        Map<Long, Map<Long, Integer>> seenHashes = new HashMap<>();
        seenHashes.computeIfAbsent(currentHash1, k -> new HashMap<>()).put(currentHash2, 0);

        for (int i = len; i < N; i++) {
            currentHash1 = (currentHash1 - (nums[i - len] * powers1[len - 1]) % mod1 + mod1) % mod1;
            currentHash2 = (currentHash2 - (nums[i - len] * powers2[len - 1]) % mod2 + mod2) % mod2;

            currentHash1 = (currentHash1 * base1 + nums[i]) % mod1;
            currentHash2 = (currentHash2 * base2 + nums[i]) % mod2;

            if (seenHashes.containsKey(currentHash1)) {
                Map<Long, Integer> innerMap = seenHashes.get(currentHash1);
                if (innerMap.containsKey(currentHash2)) {
                    return innerMap.get(currentHash2);
                }
            }
            seenHashes.computeIfAbsent(currentHash1, k -> new HashMap<>()).put(currentHash2, i - len + 1);
        }

        return -1;
    }

    public String longestDuplicateSubstring(String s) {
        N = s.length();
        nums = new int[N];
        for (int i = 0; i < N; i++) {
            nums[i] = s.charAt(i) - 'a' + 1;
        }

        powers1 = new long[N];
        powers2 = new long[N];
        powers1[0] = 1;
        powers2[0] = 1;
        for (int i = 1; i < N; i++) {
            powers1[i] = (powers1[i - 1] * base1) % mod1;
            powers2[i] = (powers2[i - 1] * base2) % mod2;
        }

        int longestLen = 0;
        int startIndex = 0;

        int low = 0, high = N - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int currentStartIndex = check(mid);
            if (currentStartIndex != -1) {
                longestLen = mid;
                startIndex = currentStartIndex;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return s.substring(startIndex, startIndex + longestLen);
    }
}