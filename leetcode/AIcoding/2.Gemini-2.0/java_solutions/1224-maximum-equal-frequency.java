import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxEqualFreq(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        Map<Integer, Integer> count = new HashMap<>();
        int maxFreq = 0;
        int ans = 0;

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            if (freq.containsKey(num)) {
                int oldFreq = freq.get(num);
                count.put(oldFreq, count.get(oldFreq) - 1);
                if (count.get(oldFreq) == 0) {
                    count.remove(oldFreq);
                }
                freq.put(num, oldFreq + 1);
                count.put(oldFreq + 1, count.getOrDefault(oldFreq + 1, 0) + 1);
                maxFreq = Math.max(maxFreq, oldFreq + 1);
            } else {
                freq.put(num, 1);
                count.put(1, count.getOrDefault(1, 0) + 1);
                maxFreq = Math.max(maxFreq, 1);
            }

            if (count.size() == 1) {
                int f = count.keySet().iterator().next();
                if (f == 1 || count.get(f) == 1) {
                    ans = i + 1;
                }
            } else if (count.size() == 2) {
                Integer[] keys = count.keySet().toArray(new Integer[0]);
                int f1 = keys[0];
                int f2 = keys[1];

                if ((f1 == 1 && count.get(f1) == 1) || (f2 == 1 && count.get(f2) == 1)) {
                    ans = i + 1;
                } else if ((f1 == maxFreq && count.get(f1) == 1 && f1 == f2 + 1) || (f2 == maxFreq && count.get(f2) == 1 && f2 == f1 + 1)) {
                     ans = i + 1;
                }
            }
        }

        return ans;
    }
}