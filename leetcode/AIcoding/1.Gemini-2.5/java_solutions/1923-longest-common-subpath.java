import java.util.*;

class Solution {

    private static final long M1 = 1_000_000_007L;
    private static final long M2 = 1_000_000_009L;
    private static final long P1 = 200003L; 
    private static final long P2 = 200011L; 

    private long[] powP1;
    private long[] powP2;
    private int maxPathLength;

    public int longestCommonSubpath(int n, int[][] paths) {
        maxPathLength = 0;
        int minPathLength = Integer.MAX_VALUE;
        for (int[] path : paths) {
            maxPathLength = Math.max(maxPathLength, path.length);
            minPathLength = Math.min(minPathLength, path.length);
        }

        powP1 = new long[maxPathLength + 1];
        powP2 = new long[maxPathLength + 1];
        powP1[0] = 1;
        powP2[0] = 1;
        for (int i = 1; i <= maxPathLength; i++) {
            powP1[i] = (powP1[i - 1] * P1) % M1;
            powP2[i] = (powP2[i - 1] * P2) % M2;
        }

        int low = 0;
        int high = minPathLength;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (mid == 0) {
                ans = Math.max(ans, mid);
                low = mid + 1;
                continue;
            }
            if (check(paths, mid)) {
                ans = Math.max(ans, mid);
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean check(int[][] paths, int len) {
        if (len == 0) {
            return true;
        }

        Set<Long> commonHashes = getHashes(paths[0], len);
        if (commonHashes.isEmpty()) {
            return false;
        }

        for (int i = 1; i < paths.length; i++) {
            Set<Long> currentPathHashes = getHashes(paths[i], len);
            commonHashes.retainAll(currentPathHashes); 
            if (commonHashes.isEmpty()) {
                return false; 
            }
        }
        return !commonHashes.isEmpty();
    }

    private Set<Long> getHashes(int[] path, int len) {
        Set<Long> hashes = new HashSet<>();
        if (path.length < len) {
            return hashes;
        }

        long currentHash1 = 0;
        long currentHash2 = 0;

        for (int i = 0; i < len; i++) {
            currentHash1 = (currentHash1 * P1 + path[i]) % M1;
            currentHash2 = (currentHash2 * P2 + path[i]) % M2;
        }
        hashes.add((currentHash1 << 32) | currentHash2);

        for (int i = len; i < path.length; i++) {
            currentHash1 = (currentHash1 - (path[i - len] * powP1[len - 1]) % M1 + M1) % M1;
            currentHash2 = (currentHash2 - (path[i - len] * powP2[len - 1]) % M2 + M2) % M2;

            currentHash1 = (currentHash1 * P1) % M1;
            currentHash2 = (currentHash2 * P2) % M2;

            currentHash1 = (currentHash1 + path[i]) % M1;
            currentHash2 = (currentHash2 + path[i]) % M2;

            hashes.add((currentHash1 << 32) | currentHash2);
        }
        return hashes;
    }
}