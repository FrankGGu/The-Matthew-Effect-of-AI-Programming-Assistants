import java.util.HashMap;
import java.util.Map;

class FindSumPairs {

    private int[] nums1;
    private int[] nums2;
    private Map<Integer, Integer> countMap;

    public FindSumPairs(int[] nums1, int[] nums2) {
        this.nums1 = nums1;
        this.nums2 = nums2;
        this.countMap = new HashMap<>();
        for (int num : nums2) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
    }

    public void add(int index, int val) {
        int originalVal = nums2[index];
        countMap.put(originalVal, countMap.get(originalVal) - 1);
        if (countMap.get(originalVal) == 0) {
            countMap.remove(originalVal);
        }
        nums2[index] += val;
        countMap.put(nums2[index], countMap.getOrDefault(nums2[index], 0) + 1);
    }

    public int count(int tot) {
        int count = 0;
        for (int num : nums1) {
            count += countMap.getOrDefault(tot - num, 0);
        }
        return count;
    }
}