class DetectSquares {
    private Map<Integer, Map<Integer, Integer>> pointCount;

    public DetectSquares() {
        pointCount = new HashMap<>();
    }

    public void add(int[] point) {
        int x = point[0], y = point[1];
        pointCount.putIfAbsent(x, new HashMap<>());
        Map<Integer, Integer> yCount = pointCount.get(x);
        yCount.put(y, yCount.getOrDefault(y, 0) + 1);
    }

    public int count(int[] point) {
        int x = point[0], y = point[1];
        if (!pointCount.containsKey(x)) {
            return 0;
        }
        int res = 0;
        Map<Integer, Integer> yCount = pointCount.get(x);
        for (int y1 : yCount.keySet()) {
            if (y1 == y) continue;
            int len = Math.abs(y1 - y);
            int x1 = x + len;
            if (pointCount.containsKey(x1)) {
                Map<Integer, Integer> yCount1 = pointCount.get(x1);
                if (yCount1.containsKey(y) && yCount1.containsKey(y1)) {
                    res += yCount.get(y1) * yCount1.get(y) * yCount1.get(y1);
                }
            }
            x1 = x - len;
            if (pointCount.containsKey(x1)) {
                Map<Integer, Integer> yCount1 = pointCount.get(x1);
                if (yCount1.containsKey(y) && yCount1.containsKey(y1)) {
                    res += yCount.get(y1) * yCount1.get(y) * yCount1.get(y1);
                }
            }
        }
        return res;
    }
}