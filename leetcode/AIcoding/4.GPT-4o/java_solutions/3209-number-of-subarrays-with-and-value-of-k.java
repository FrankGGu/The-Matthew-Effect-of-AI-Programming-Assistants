import java.util.HashMap;

public class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int count = 0;
        HashMap<Integer, Integer> freqMap = new HashMap<>();
        int currentAnd = 0;

        for (int left = 0; left < n; left++) {
            currentAnd = nums[left];
            if (currentAnd == k) count++;
            freqMap.put(currentAnd, freqMap.getOrDefault(currentAnd, 0) + 1);
            for (int right = left + 1; right < n; right++) {
                currentAnd &= nums[right];
                if (currentAnd == k) count++;
                freqMap.put(currentAnd, freqMap.getOrDefault(currentAnd, 0) + 1);
            }
            freqMap.clear();
        }

        return count;
    }
}