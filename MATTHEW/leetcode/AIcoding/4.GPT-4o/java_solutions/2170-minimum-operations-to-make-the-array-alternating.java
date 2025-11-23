import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumOperations(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int n = nums.length;
        int[] freq = new int[count.size()];
        int idx = 0;
        for (int val : count.values()) {
            freq[idx++] = val;
        }

        Arrays.sort(freq);

        int max1 = freq[freq.length - 1];
        int max2 = freq.length > 1 ? freq[freq.length - 2] : 0;

        int maxFreq = count.size() == 1 ? 0 : (max1 + max2);

        return n - maxFreq;
    }
}