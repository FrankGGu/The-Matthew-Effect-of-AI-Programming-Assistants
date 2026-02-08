class Solution {
    public int maxPointsInsideSquare(int[][] points, String s) {
        int n = points.length;
        int[] tags = new int[26];
        Arrays.fill(tags, Integer.MAX_VALUE);

        for (int i = 0; i < n; i++) {
            int x = Math.abs(points[i][0]);
            int y = Math.abs(points[i][1]);
            int maxDist = Math.max(x, y);
            char c = s.charAt(i);
            if (maxDist < tags[c - 'a']) {
                tags[c - 'a'] = maxDist;
            }
        }

        Arrays.sort(tags);
        int res = 0;
        for (int i = 0; i < 26; i++) {
            if (tags[i] == Integer.MAX_VALUE) {
                continue;
            }
            if (i == 0 || tags[i] > tags[i - 1]) {
                res = i + 1;
            } else {
                break;
            }
        }
        return res;
    }
}