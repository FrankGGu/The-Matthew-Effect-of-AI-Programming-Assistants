class Solution {
    private static final long BASE1 = 100003;
    private static final long BASE2 = 100019;
    private static final long MOD1 = 1000000007;
    private static final long MOD2 = 1000000009;

    public int longestCommonSubpath(int n, int[][] paths) {
        int left = 1;
        int right = getMinLength(paths);
        int answer = 0;

        while (left <= right) {
            int mid = (left + right) / 2;
            if (hasCommonSubpath(paths, mid)) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }

    private int getMinLength(int[][] paths) {
        int min = Integer.MAX_VALUE;
        for (int[] path : paths) {
            min = Math.min(min, path.length);
        }
        return min;
    }

    private boolean hasCommonSubpath(int[][] paths, int len) {
        Map<Long, Integer> freqMap = new HashMap<>();
        long maxPow1 = 1;
        long maxPow2 = 1;

        for (int i = 0; i < len - 1; i++) {
            maxPow1 = (maxPow1 * BASE1) % MOD1;
            maxPow2 = (maxPow2 * BASE2) % MOD2;
        }

        for (int i = 0; i < paths.length; i++) {
            long hash1 = 0;
            long hash2 = 0;
            Set<Long> seen = new HashSet<>();

            for (int j = 0; j < paths[i].length; j++) {
                if (j >= len) {
                    long prev = paths[i][j - len];
                    hash1 = (hash1 - prev * maxPow1 % MOD1 + MOD1) % MOD1;
                    hash2 = (hash2 - prev * maxPow2 % MOD2 + MOD2) % MOD2;
                }
                hash1 = (hash1 * BASE1 + paths[i][j]) % MOD1;
                hash2 = (hash2 * BASE2 + paths[i][j]) % MOD2;

                if (j >= len - 1) {
                    long combinedHash = (hash1 << 32) | hash2;
                    if (!seen.contains(combinedHash)) {
                        seen.add(combinedHash);
                        freqMap.put(combinedHash, freqMap.getOrDefault(combinedHash, 0) + 1);
                    }
                }
            }
        }

        for (int count : freqMap.values()) {
            if (count == paths.length) {
                return true;
            }
        }
        return false;
    }
}