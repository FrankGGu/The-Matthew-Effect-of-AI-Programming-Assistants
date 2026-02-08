class Solution {
    public int maxDiffBetweenEvenAndOddFreq(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        int maxEven = -1;
        int minOdd = Integer.MAX_VALUE;
        for (int count : freq.values()) {
            if (count % 2 == 0) {
                if (count > maxEven) {
                    maxEven = count;
                }
            } else {
                if (count < minOdd) {
                    minOdd = count;
                }
            }
        }
        if (maxEven == -1 || minOdd == Integer.MAX_VALUE) {
            return 0;
        }
        return maxEven - minOdd;
    }
}