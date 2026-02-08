import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public long[] mostFrequentIDs(int[] nums, int[] freqs) {
        int n = nums.length;
        long[] ans = new long[n];

        Map<Integer, Long> idFreqMap = new HashMap<>();
        TreeMap<Long, Integer> freqCounts = new TreeMap<>();

        for (int i = 0; i < n; i++) {
            int id = nums[i];
            int delta = freqs[i];

            long oldFreq = idFreqMap.getOrDefault(id, 0L);
            long newFreq = oldFreq + delta;

            idFreqMap.put(id, newFreq);

            if (oldFreq > 0) {
                freqCounts.put(oldFreq, freqCounts.get(oldFreq) - 1);
                if (freqCounts.get(oldFreq) == 0) {
                    freqCounts.remove(oldFreq);
                }
            }

            if (newFreq > 0) {
                freqCounts.put(newFreq, freqCounts.getOrDefault(newFreq, 0) + 1);
            }

            if (freqCounts.isEmpty()) {
                ans[i] = 0L;
            } else {
                ans[i] = freqCounts.lastKey();
            }
        }

        return ans;
    }
}