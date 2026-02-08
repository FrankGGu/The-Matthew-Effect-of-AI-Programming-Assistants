class Solution {
    public String shortestStringContainingThreeStrings(String s1, String s2, String s3) {
        String[] strs = {s1, s2, s3};
        String ans = s1 + s2 + s3; 

        int[][] permutations = {
            {0, 1, 2}, {0, 2, 1},
            {1, 0, 2}, {1, 2, 0},
            {2, 0, 1}, {2, 1, 0}
        };

        for (int[] p : permutations) {
            String temp = merge(strs[p[0]], strs[p[1]]);
            String currentResult = merge(temp, strs[p[2]]);

            if (currentResult.length() < ans.length()) {
                ans = currentResult;
            } else if (currentResult.length() == ans.length()) {
                if (currentResult.compareTo(ans) < 0) {
                    ans = currentResult;
                }
            }
        }
        return ans;
    }

    private String merge(String s1, String s2) {
        if (s1.contains(s2)) return s1;
        if (s2.contains(s1)) return s2;

        String bestRes = s1 + s2;

        int maxOverlap1 = 0;
        for (int k = 1; k <= Math.min(s1.length(), s2.length()); k++) {
            if (s1.endsWith(s2.substring(0, k))) {
                maxOverlap1 = k;
            }
        }
        String current1 = s1 + s2.substring(maxOverlap1);
        if (current1.length() < bestRes.length()) {
            bestRes = current1;
        } else if (current1.length() == bestRes.length()) {
            if (current1.compareTo(bestRes) < 0) {
                bestRes = current1;
            }
        }

        int maxOverlap2 = 0;
        for (int k = 1; k <= Math.min(s1.length(), s2.length()); k++) {
            if (s2.endsWith(s1.substring(0, k))) {
                maxOverlap2 = k;
            }
        }
        String current2 = s2 + s1.substring(maxOverlap2);
        if (current2.length() < bestRes.length()) {
            bestRes = current2;
        } else if (current2.length() == bestRes.length()) {
            if (current2.compareTo(bestRes) < 0) {
                bestRes = current2;
            }
        }

        return bestRes;
    }
}