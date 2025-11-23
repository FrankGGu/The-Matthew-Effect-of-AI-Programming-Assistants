class Solution {
    public long countExcellentPairs(int[] nums, int k) {
        Set<Integer> uniqueNums = new HashSet<>();
        for (int num : nums) {
            uniqueNums.add(num);
        }
        int[] bitCounts = new int[uniqueNums.size()];
        int index = 0;
        for (int num : uniqueNums) {
            bitCounts[index++] = Integer.bitCount(num);
        }
        Arrays.sort(bitCounts);
        long res = 0;
        for (int i = 0; i < bitCounts.length; i++) {
            int target = Math.max(0, k - bitCounts[i]);
            int left = 0, right = bitCounts.length;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (bitCounts[mid] < target) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            res += bitCounts.length - left;
        }
        return res;
    }
}