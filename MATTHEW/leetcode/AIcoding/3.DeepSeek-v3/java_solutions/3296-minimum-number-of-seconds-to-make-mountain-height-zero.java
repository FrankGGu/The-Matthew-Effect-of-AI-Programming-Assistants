class Solution {
    public int minimumSeconds(List<Integer> nums) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < nums.size(); i++) {
            int num = nums.get(i);
            map.computeIfAbsent(num, k -> new ArrayList<>()).add(i);
        }

        int minTime = Integer.MAX_VALUE;
        for (List<Integer> positions : map.values()) {
            int maxGap = 0;
            int n = positions.size();
            for (int i = 0; i < n; i++) {
                int prev = positions.get((i - 1 + n) % n);
                int curr = positions.get(i);
                int gap = (curr - prev - 1 + nums.size()) % nums.size();
                maxGap = Math.max(maxGap, gap);
            }
            int time = (maxGap + 1) / 2;
            minTime = Math.min(minTime, time);
        }
        return minTime;
    }
}