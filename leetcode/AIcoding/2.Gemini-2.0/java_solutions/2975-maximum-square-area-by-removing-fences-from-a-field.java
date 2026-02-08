import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximizeSquareArea(int m, int n, int[] hFences, int[] vFences) {
        Arrays.sort(hFences);
        Arrays.sort(vFences);

        Set<Integer> hDiffs = new HashSet<>();
        for (int i = -1; i < hFences.length; i++) {
            for (int j = i + 1; j < hFences.length + 1; j++) {
                int h1 = (i == -1) ? 1 : hFences[i];
                int h2 = (j == hFences.length) ? m : hFences[j];
                hDiffs.add(h2 - h1);
            }
        }

        Set<Integer> vDiffs = new HashSet<>();
        for (int i = -1; i < vFences.length; i++) {
            for (int j = i + 1; j < vFences.length + 1; j++) {
                int v1 = (i == -1) ? 1 : vFences[i];
                int v2 = (j == vFences.length) ? n : vFences[j];
                vDiffs.add(v2 - v1);
            }
        }

        long maxSide = 0;
        for (int hDiff : hDiffs) {
            if (vDiffs.contains(hDiff)) {
                maxSide = Math.max(maxSide, hDiff);
            }
        }

        if (maxSide == 0) {
            return -1;
        }

        long mod = 1000000007;
        return (int) ((maxSide % mod) * (maxSide % mod) % mod);
    }
}