class Solution {
    public int[] countRectangles(int[][] rectangles, int[][] points) {
        List<List<Integer>> rects = new ArrayList<>(101);
        for (int i = 0; i <= 100; i++) {
            rects.add(new ArrayList<>());
        }
        for (int[] rect : rectangles) {
            int l = rect[0], h = rect[1];
            rects.get(h).add(l);
        }
        for (int i = 0; i <= 100; i++) {
            Collections.sort(rects.get(i));
        }
        int[] res = new int[points.length];
        for (int i = 0; i < points.length; i++) {
            int x = points[i][0], y = points[i][1];
            int count = 0;
            for (int j = y; j <= 100; j++) {
                List<Integer> xs = rects.get(j);
                int left = 0, right = xs.size();
                while (left < right) {
                    int mid = left + (right - left) / 2;
                    if (xs.get(mid) >= x) {
                        right = mid;
                    } else {
                        left = mid + 1;
                    }
                }
                count += xs.size() - left;
            }
            res[i] = count;
        }
        return res;
    }
}