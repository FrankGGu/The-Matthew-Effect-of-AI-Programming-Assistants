class Solution {
    public double minAreaFreeRect(int[][] points) {
        Map<String, List<int[]>> map = new HashMap<>();
        double minArea = Double.MAX_VALUE;
        int n = points.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int[] p1 = points[i];
                int[] p2 = points[j];
                double centerX = p1[0] + p2[0];
                double centerY = p1[1] + p2[1];
                double dx = p1[0] - p2[0];
                double dy = p1[1] - p2[1];
                double len = dx * dx + dy * dy;
                String key = centerX + "," + centerY + "," + len;
                map.putIfAbsent(key, new ArrayList<>());
                map.get(key).add(new int[]{i, j});
            }
        }

        for (String key : map.keySet()) {
            List<int[]> list = map.get(key);
            if (list.size() < 2) continue;
            for (int i = 0; i < list.size(); i++) {
                for (int j = i + 1; j < list.size(); j++) {
                    int[] a = points[list.get(i)[0]];
                    int[] b = points[list.get(i)[1]];
                    int[] c = points[list.get(j)[0]];
                    double abx = b[0] - a[0];
                    double aby = b[1] - a[1];
                    double acx = c[0] - a[0];
                    double acy = c[1] - a[1];
                    double area = Math.abs(abx * acy - aby * acx);
                    if (area < minArea) {
                        minArea = area;
                    }
                }
            }
        }

        return minArea == Double.MAX_VALUE ? 0 : minArea;
    }
}