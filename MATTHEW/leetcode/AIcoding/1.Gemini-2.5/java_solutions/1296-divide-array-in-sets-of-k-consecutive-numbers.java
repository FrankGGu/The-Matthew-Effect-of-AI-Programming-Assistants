import java.util.Map;
import java.util.TreeMap;

class Solution {
    public boolean isPossibleDivide(int[] nums, int k) {
        if (nums.length % k != 0) {
            return false;
        }

        TreeMap<Integer, Integer> counts = new TreeMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        while (!counts.isEmpty()) {
            int startNum = counts.firstKey();
            for (int i = 0; i < k; i++) {
                int currentNum = startNum + i;
                if (!counts.containsKey(currentNum)) {
                    return false;
                }
                int count = counts.get(currentNum);
                if (count == 1) {
                    counts.remove(currentNum);
                } else {
                    counts.put(currentNum, count - 1);
                }
            }
        }

        return true;
    }
}