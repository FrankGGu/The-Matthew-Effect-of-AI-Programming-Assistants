class Solution {
    public double minAreaFreeRect(int[][] points) {
        Map<String, List<int[]>> map = new HashMap<>();
        int n = points.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int[] p1 = points[i];
                int[] p2 = points[j];
                double centerX = p1[0] + p2[0];
                double centerY = p1[1] + p2[1];
                double distance = Math.pow(p1[0] - p2[0], 2) + Math.pow(p1[1] - p2[1], 2);
                String key = centerX + "," + centerY + "," + distance;
                map.putIfAbsent(key, new ArrayList<>());
                map.get(key).add(new int[]{i, j});
            }
        }
        double res = Double.MAX_VALUE;
        for (String key : map.keySet()) {
            List<int[]> list = map.get(key);
            if (list.size() < 2) continue;
            for (int i = 0; i < list.size(); i++) {
                for (int j = i + 1; j < list.size(); j++) {
                    int[] p1 = points[list.get(i)[0]];
                    int[] p2 = points[list.get(j)[0]];
                    int[] p3 = points[list.get(j)[1]];
                    double len1 = Math.sqrt(Math.pow(p1[0] - p2[0], 2) + Math.pow(p1[1] - p2[1], 2));
                    double len2 = Math.sqrt(Math.pow(p1[0] - p3[0], 2) + Math.pow(p1[1] - p3[1], 2));
                    double area = len1 * len2;
                    res = Math.min(res, area);
                }
            }
        }
        return res == Double.MAX_VALUE ? 0 : res;
    }
}