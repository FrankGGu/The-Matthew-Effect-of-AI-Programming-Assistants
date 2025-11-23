import java.util.*;

class Solution {
    private static final long MOD = 1000000007;
    private static final long BASE = 29;

    public int longestCommonSubpath(int n, int[][] paths) {
        int minLen = Integer.MAX_VALUE;
        for (int[] path : paths) {
            minLen = Math.min(minLen, path.length);
        }

        int low = 0, high = minLen;
        int result = 0;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (isCommon(paths, mid)) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return result;
    }

    private boolean isCommon(int[][] paths, int len) {
        if (len == 0) {
            return true;
        }

        Set<Long> commonHashes = null;
        for (int[] path : paths) {
            if (path.length < len) {
                return false;
            }

            Set<Long> currentHashes = new HashSet<>();
            long hash = 0;
            long power = 1;
            for (int i = 0; i < len; i++) {
                hash = (hash * BASE + path[i]) % MOD;
                if (i < len - 1) {
                    power = (power * BASE) % MOD;
                }
            }
            currentHashes.add(hash);

            for (int i = len; i < path.length; i++) {
                hash = (hash - power * path[i - len] % MOD + MOD) % MOD;
                hash = (hash * BASE + path[i]) % MOD;
                currentHashes.add(hash);
            }

            if (commonHashes == null) {
                commonHashes = currentHashes;
            } else {
                commonHashes.retainAll(currentHashes);
                if (commonHashes.isEmpty()) {
                    return false;
                }
            }
        }
        return true;
    }
}