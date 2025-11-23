class Solution {
    public boolean[] canMakePalindromeQueries(String s, int[][] queries) {
        int n = s.length();
        int half = n / 2;
        String firstHalf = s.substring(0, half);
        String secondHalf = new StringBuilder(s.substring(half)).reverse().toString();

        if (!firstHalf.equals(secondHalf)) {
            return new boolean[queries.length];
        }

        int[] prefixDiff = new int[half + 1];
        for (int i = 0; i < half; i++) {
            prefixDiff[i + 1] = prefixDiff[i] + (firstHalf.charAt(i) != secondHalf.charAt(i) ? 1 : 0);
        }

        boolean[] result = new boolean[queries.length];
        for (int q = 0; q < queries.length; q++) {
            int[] query = queries[q];
            int a = query[0], b = query[1], c = query[2], d = query[3];
            int cRev = n - 1 - d;
            int dRev = n - 1 - c;

            int left = Math.min(a, cRev);
            int right = Math.max(b, dRev);

            int totalDiff = prefixDiff[right + 1] - prefixDiff[left];
            if (totalDiff == 0) {
                result[q] = true;
                continue;
            }

            int overlapLeft = Math.max(a, cRev);
            int overlapRight = Math.min(b, dRev);

            if (overlapLeft > overlapRight) {
                result[q] = false;
                continue;
            }

            int overlapDiff = prefixDiff[overlapRight + 1] - prefixDiff[overlapLeft];
            if (overlapDiff == totalDiff) {
                result[q] = true;
            } else {
                result[q] = false;
            }
        }
        return result;
    }
}