class Solution {
    public int maxIncreasingGroups(List<Integer> usageLimits) {
        Collections.sort(usageLimits);
        long total = 0;
        int res = 0;
        for (int num : usageLimits) {
            total += num;
            if (total >= (res + 1L) * (res + 2L) / 2L) {
                res++;
            }
        }
        return res;
    }
}