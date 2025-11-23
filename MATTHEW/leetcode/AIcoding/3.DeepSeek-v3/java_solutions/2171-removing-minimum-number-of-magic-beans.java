class Solution {
    public long minimumRemoval(int[] beans) {
        Arrays.sort(beans);
        long total = 0;
        for (int bean : beans) {
            total += bean;
        }
        long minRemoval = Long.MAX_VALUE;
        int n = beans.length;
        for (int i = 0; i < n; i++) {
            long current = total - (long) beans[i] * (n - i);
            if (current < minRemoval) {
                minRemoval = current;
            }
        }
        return minRemoval;
    }
}