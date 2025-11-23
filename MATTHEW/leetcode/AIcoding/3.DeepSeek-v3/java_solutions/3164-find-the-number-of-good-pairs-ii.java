class Solution {
    public long numberOfPairs(int[] nums1, int[] nums2, int k) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums2) {
            int key = num * k;
            freq.put(key, freq.getOrDefault(key, 0) + 1);
        }

        long res = 0;
        for (int num : nums1) {
            if (num % k != 0) continue;
            int target = num / k;
            for (int d = 1; d * d <= target; d++) {
                if (target % d == 0) {
                    res += freq.getOrDefault(d, 0);
                    if (d * d != target) {
                        res += freq.getOrDefault(target / d, 0);
                    }
                }
            }
        }
        return res;
    }
}