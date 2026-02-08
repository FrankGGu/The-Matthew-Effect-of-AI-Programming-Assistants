class Solution {
    public List<List<Long>> splitPainting(int[][] segments) {
        TreeMap<Integer, Long> map = new TreeMap<>();
        for (int[] seg : segments) {
            int start = seg[0];
            int end = seg[1];
            int color = seg[2];
            map.put(start, map.getOrDefault(start, 0L) + color);
            map.put(end, map.getOrDefault(end, 0L) - color);
        }

        List<List<Long>> res = new ArrayList<>();
        long prevPos = 0, prevColor = 0;
        for (int pos : map.keySet()) {
            if (prevColor != 0) {
                res.add(Arrays.asList(prevPos, (long) pos, prevColor));
            }
            prevColor += map.get(pos);
            prevPos = pos;
        }

        return res;
    }
}