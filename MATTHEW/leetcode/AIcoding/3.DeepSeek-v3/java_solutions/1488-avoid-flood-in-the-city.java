class Solution {
    public int[] avoidFlood(int[] rains) {
        int n = rains.length;
        int[] res = new int[n];
        Arrays.fill(res, 1);
        TreeSet<Integer> dryDays = new TreeSet<>();
        Map<Integer, Integer> lakeToRainDay = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int lake = rains[i];
            if (lake == 0) {
                dryDays.add(i);
            } else {
                res[i] = -1;
                if (lakeToRainDay.containsKey(lake)) {
                    Integer dryDay = dryDays.higher(lakeToRainDay.get(lake));
                    if (dryDay == null) {
                        return new int[0];
                    }
                    res[dryDay] = lake;
                    dryDays.remove(dryDay);
                }
                lakeToRainDay.put(lake, i);
            }
        }
        return res;
    }
}