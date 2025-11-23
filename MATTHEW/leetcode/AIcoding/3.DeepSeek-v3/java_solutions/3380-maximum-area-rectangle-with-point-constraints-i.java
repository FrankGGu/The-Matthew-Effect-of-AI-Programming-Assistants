class Solution {
    public int[] countRectangles(int[][] rectangles, int[][] points) {
        int n = rectangles.length;
        int m = points.length;
        int[] res = new int[m];
        List<List<Integer>> heights = new ArrayList<>();
        for (int i = 0; i <= 100; i++) {
            heights.add(new ArrayList<>());
        }
        for (int[] rect : rectangles) {
            int l = rect[0];
            int h = rect[1];
            heights.get(h).add(l);
        }
        for (int i = 0; i <= 100; i++) {
            Collections.sort(heights.get(i));
        }
        for (int i = 0; i < m; i++) {
            int x = points[i][0];
            int y = points[i][1];
            int count = 0;
            for (int h = y; h <= 100; h++) {
                List<Integer> list = heights.get(h);
                int left = 0, right = list.size();
                while (left < right) {
                    int mid = left + (right - left) / 2;
                    if (list.get(mid) >= x) {
                        right = mid;
                    } else {
                        left = mid + 1;
                    }
                }
                count += list.size() - left;
            }
            res[i] = count;
        }
        return res;
    }
}