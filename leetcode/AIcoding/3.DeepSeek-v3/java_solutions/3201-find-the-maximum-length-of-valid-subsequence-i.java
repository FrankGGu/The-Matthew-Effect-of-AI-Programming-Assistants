class Solution {
    public int maximumLength(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int maxLen = 0;
        for (int num : nums) {
            int current = num;
            int len = 0;
            while (freq.containsKey(current) && freq.get(current) >= 1) {
                int count = freq.get(current);
                if (count == 1) {
                    freq.remove(current);
                } else {
                    freq.put(current, count - 1);
                }
                len++;
                current *= current;
            }
            maxLen = Math.max(maxLen, len);
        }
        return maxLen == 0 ? -1 : maxLen;
    }
}