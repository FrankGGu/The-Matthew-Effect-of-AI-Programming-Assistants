class Solution {
    public long continuousSubarrays(int[] nums) {
        long count = 0;
        int left = 0;
        java.util.TreeMap<Integer, Integer> map = new java.util.TreeMap<>();

        for (int right = 0; right < nums.length; right++) {
            map.put(nums[right], map.getOrDefault(nums[right], 0) + 1);

            while (map.lastKey() - map.firstKey() > 2) {
                map.put(nums[left], map.get(nums[left]) - 1);
                if (map.get(nums[left]) == 0) {
                    map.remove(nums[left]);
                }
                left++;
            }

            count += (right - left + 1);
        }

        return count;
    }
}