class FindSumPairs {
    private int[] nums1;
    private int[] nums2;
    private Map<Integer, Integer> freq;

    public FindSumPairs(int[] nums1, int[] nums2) {
        this.nums1 = nums1;
        this.nums2 = nums2;
        this.freq = new HashMap<>();
        for (int num : nums2) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
    }

    public void add(int index, int val) {
        int oldVal = nums2[index];
        freq.put(oldVal, freq.get(oldVal) - 1);
        nums2[index] += val;
        int newVal = nums2[index];
        freq.put(newVal, freq.getOrDefault(newVal, 0) + 1);
    }

    public int count(int tot) {
        int res = 0;
        for (int num : nums1) {
            res += freq.getOrDefault(tot - num, 0);
        }
        return res;
    }
}