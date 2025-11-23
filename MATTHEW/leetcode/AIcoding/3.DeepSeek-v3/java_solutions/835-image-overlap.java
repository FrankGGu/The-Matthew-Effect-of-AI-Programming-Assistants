class Solution {
    public int largestOverlap(int[][] img1, int[][] img2) {
        int n = img1.length;
        List<int[]> list1 = new ArrayList<>();
        List<int[]> list2 = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (img1[i][j] == 1) {
                    list1.add(new int[]{i, j});
                }
                if (img2[i][j] == 1) {
                    list2.add(new int[]{i, j});
                }
            }
        }

        Map<String, Integer> map = new HashMap<>();
        int max = 0;

        for (int[] a : list1) {
            for (int[] b : list2) {
                String key = (a[0] - b[0]) + "," + (a[1] - b[1]);
                map.put(key, map.getOrDefault(key, 0) + 1);
                max = Math.max(max, map.get(key));
            }
        }

        return max;
    }
}