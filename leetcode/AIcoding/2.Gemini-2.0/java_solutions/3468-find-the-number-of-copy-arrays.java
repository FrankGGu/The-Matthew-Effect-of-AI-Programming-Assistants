import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findCopiedArrays(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int copiedArrays = 0;
        for (int count : countMap.values()) {
            copiedArrays += (count / 2);
        }

        return copiedArrays;
    }
}