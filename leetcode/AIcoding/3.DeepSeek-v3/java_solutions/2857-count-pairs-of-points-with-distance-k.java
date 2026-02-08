class Solution {
    public int countPairs(List<List<Integer>> coordinates, int k) {
        Map<String, Integer> map = new HashMap<>();
        int res = 0;
        for (List<Integer> point : coordinates) {
            int x1 = point.get(0);
            int y1 = point.get(1);
            for (int a = 0; a <= k; a++) {
                int b = k - a;
                int x2 = x1 ^ a;
                int y2 = y1 ^ b;
                String key = x2 + "," + y2;
                res += map.getOrDefault(key, 0);
            }
            String key = x1 + "," + y1;
            map.put(key, map.getOrDefault(key, 0) + 1);
        }
        return res;
    }
}