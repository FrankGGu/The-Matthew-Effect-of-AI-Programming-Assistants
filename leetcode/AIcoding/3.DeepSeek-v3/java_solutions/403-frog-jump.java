class Solution {
    public boolean canCross(int[] stones) {
        if (stones == null || stones.length == 0) {
            return false;
        }
        int n = stones.length;
        if (n == 1) {
            return true;
        }
        if (stones[1] != 1) {
            return false;
        }
        if (n == 2) {
            return true;
        }
        Map<Integer, Set<Integer>> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            map.put(stones[i], new HashSet<>());
        }
        map.get(0).add(1);

        for (int i = 0; i < n - 1; i++) {
            int stone = stones[i];
            for (int step : map.get(stone)) {
                int reach = stone + step;
                if (reach == stones[n - 1]) {
                    return true;
                }
                if (map.containsKey(reach)) {
                    Set<Integer> set = map.get(reach);
                    if (step - 1 > 0) {
                        set.add(step - 1);
                    }
                    set.add(step);
                    set.add(step + 1);
                }
            }
        }
        return false;
    }
}