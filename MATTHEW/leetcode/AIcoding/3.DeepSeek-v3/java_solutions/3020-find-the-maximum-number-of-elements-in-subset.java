class Solution {
    public int maximumLength(int[] nums) {
        Map<Long, Integer> freq = new HashMap<>();
        for (int num : nums) {
            long key = (long) num;
            freq.put(key, freq.getOrDefault(key, 0) + 1);
        }

        int maxLen = 1;
        for (long num : freq.keySet()) {
            int currentLen = 0;
            long current = num;
            while (freq.containsKey(current)) {
                int count = freq.get(current);
                if (current == 1) {
                    if (count % 2 == 0) {
                        currentLen += count - 1;
                    } else {
                        currentLen += count;
                    }
                    break;
                }
                if (count < 2) {
                    currentLen += 1;
                    break;
                }
                currentLen += 2;
                current = current * current;
            }
            maxLen = Math.max(maxLen, currentLen);
        }
        return maxLen;
    }
}