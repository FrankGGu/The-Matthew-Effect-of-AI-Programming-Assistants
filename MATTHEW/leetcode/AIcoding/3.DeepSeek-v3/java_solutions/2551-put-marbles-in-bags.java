class Solution {
    public long putMarbles(int[] weights, int k) {
        int n = weights.length;
        if (k == 1 || n == k) {
            return 0;
        }
        List<Integer> splits = new ArrayList<>();
        for (int i = 0; i < n - 1; i++) {
            splits.add(weights[i] + weights[i + 1]);
        }
        Collections.sort(splits);
        long min = 0, max = 0;
        for (int i = 0; i < k - 1; i++) {
            min += splits.get(i);
            max += splits.get(splits.size() - 1 - i);
        }
        return max - min;
    }
}