import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

class Solution {
    public int maximumEqualFrequency(int[] nums) {
        Map<Integer, Integer> freqMap = new HashMap<>(); // Stores number -> its frequency
        Map<Integer, Integer> countMap = new HashMap<>(); // Stores frequency -> count of numbers with that frequency

        int ans = 0;

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];

            // Update freqMap for the current number
            int oldFreq = freqMap.getOrDefault(num, 0);
            int newFreq = oldFreq + 1;
            freqMap.put(num, newFreq);

            // Update countMap: decrement count for oldFreq
            if (oldFreq > 0) {
                countMap.put(oldFreq, countMap.get(oldFreq) - 1);
                if (countMap.get(oldFreq) == 0) {
                    countMap.remove(oldFreq);
                }
            }

            // Update countMap: increment count for newFreq
            countMap.put(newFreq, countMap.getOrDefault(newFreq, 0) + 1);

            boolean isValid = false;

            // Condition 1: All elements have frequency 1 (e.g., [1,2,3])
            // OR only one distinct element (e.g., [7,7,7,7])
            // In both cases, countMap will have only one entry.
            if (countMap.size() == 1) {
                int freq = countMap.keySet().iterator().next();
                // If the only frequency is 1 (all elements appear once)
                // OR if there's only one number that has 'freq' frequency (meaning only one distinct number)
                if (freq == 1 || countMap.get(freq) == 1) {
                    isValid = true;
                }
            }
            // Condition 2: Two types of frequencies exist
            // Sub-condition A: One element has frequency F+1, all others have F.
            //                  Removing the F+1 element makes all remaining F. (e.g., [1,1,1,2,2] -> remove one '1')
            // Sub-condition B: One element has frequency 1, all others have F.
            //                  Removing the freq 1 element makes all remaining F. (e.g., [1,1,2,2,3] -> remove '3')
            else if (countMap.size() == 2) {
                Iterator<Integer> it = countMap.keySet().iterator();
                int f1 = it.next();
                int f2 = it.next();

                int count_f1 = countMap.get(f1);
                int count_f2 = countMap.get(f2);

                // Check Sub-condition A: One frequency is (other_frequency + 1) and appears only once
                if ((f1 == f2 + 1 && count_f1 == 1) || (f2 == f1 + 1 && count_f2 == 1)) {
                    isValid = true;
                }
                // Check Sub-condition B: One frequency is 1 and appears only once
                if ((f1 == 1 && count_f1 == 1) || (f2 == 1 && count_f2 == 1)) {
                    isValid = true;
                }
            }

            if (isValid) {
                ans = i + 1;
            }
        }

        return ans;
    }
}