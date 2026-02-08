import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

class Solution {
    public List<Integer> twoOutOfThree(int[] nums1, int[] nums2, int[] nums3) {
        HashSet<Integer> set1 = new HashSet<>();
        for (int num : nums1) {
            set1.add(num);
        }

        HashSet<Integer> set2 = new HashSet<>();
        for (int num : nums2) {
            set2.add(num);
        }

        HashSet<Integer> set3 = new HashSet<>();
        for (int num : nums3) {
            set3.add(num);
        }

        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int num : set1) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        for (int num : set2) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        for (int num : set3) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : freqMap.entrySet()) {
            if (entry.getValue() >= 2) {
                result.add(entry.getKey());
            }
        }

        return result;
    }
}