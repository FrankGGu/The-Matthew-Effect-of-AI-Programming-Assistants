class Solution {
    public long minCost(int[] basket1, int[] basket2) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : basket1) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        for (int num : basket2) {
            freq.put(num, freq.getOrDefault(num, 0) - 1);
        }

        List<Integer> swaps = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            int num = entry.getKey();
            int count = entry.getValue();
            if (count % 2 != 0) {
                return -1;
            }
            for (int i = 0; i < Math.abs(count) / 2; i++) {
                swaps.add(num);
            }
        }

        Collections.sort(swaps);
        int min = Integer.MAX_VALUE;
        for (int num : basket1) {
            min = Math.min(min, num);
        }
        for (int num : basket2) {
            min = Math.min(min, num);
        }

        long res = 0;
        for (int i = 0; i < swaps.size() / 2; i++) {
            res += Math.min(swaps.get(i), 2 * min);
        }
        return res;
    }
}