class Solution {
    public int flipgame(int[] fronts, int[] backs) {
        Set<Integer> same = new HashSet<>();
        for (int i = 0; i < fronts.length; i++) {
            if (fronts[i] == backs[i]) {
                same.add(fronts[i]);
            }
        }
        int res = Integer.MAX_VALUE;
        for (int num : fronts) {
            if (!same.contains(num)) {
                res = Math.min(res, num);
            }
        }
        for (int num : backs) {
            if (!same.contains(num)) {
                res = Math.min(res, num);
            }
        }
        return res == Integer.MAX_VALUE ? 0 : res;
    }
}