import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumIndex(List<Integer> nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        int dominant = -1;
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
            if (dominant == -1 || freq.get(num) > freq.get(dominant)) {
                dominant = num;
            }
        }
        int total = freq.get(dominant);
        int count = 0;
        for (int i = 0; i < nums.size(); i++) {
            if (nums.get(i) == dominant) {
                count++;
            }
            if (count * 2 > i + 1 && (total - count) * 2 > nums.size() - i - 1) {
                return i;
            }
        }
        return -1;
    }
}