import java.util.HashMap;
import java.util.Map;

class FindSumPairs {

    private int[] nums1;
    private int[] nums2;
    private Map<Integer, Integer> freq2;

    public FindSumPairs(int[] nums1, int[] nums2) {
        this.nums1 = nums1;
        this.nums2 = nums2;
        this.freq2 = new HashMap<>();
        for (int num : nums2) {
            freq2.put(num, freq2.getOrDefault(num, 0) + 1);
        }
    }

    public void add(int index, int val) {
        int oldVal = nums2[index];
        freq2.put(oldVal, freq2.get(oldVal) - 1);

        nums2[index] += val;

        int newVal = nums2[index];
        freq2.put(newVal, freq2.getOrDefault(newVal, 0) + 1);
    }

    public long count(int tot) {
        long ans = 0;
        for (int num1 : nums1) {
            int target = tot - num1;
            ans += freq2.getOrDefault(target, 0);
        }
        return ans;
    }
}