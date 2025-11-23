import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

class Solution {
    public int[] topKFrequent(int[] nums, int k) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        List<Integer>[] buckets = new List[nums.length + 1];
        for (int i = 0; i < buckets.length; i++) {
            buckets[i] = new ArrayList<>();
        }

        for (Map.Entry<Integer, Integer> entry : freqMap.entrySet()) {
            int num = entry.getKey();
            int freq = entry.getValue();
            buckets[freq].add(num);
        }

        List<Integer> resultList = new ArrayList<>();
        for (int i = buckets.length - 1; i >= 0 && resultList.size() < k; i--) {
            if (!buckets[i].isEmpty()) {
                for (int num : buckets[i]) {
                    resultList.add(num);
                    if (resultList.size() == k) {
                        break;
                    }
                }
            }
        }

        int[] resultArray = new int[k];
        for (int i = 0; i < k; i++) {
            resultArray[i] = resultList.get(i);
        }

        return resultArray;
    }
}