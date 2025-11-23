class Solution {
    public long countCompleteSubarrays(int[] nums) {
        int n = nums.length;
        Set<Integer> uniqueElements = new HashSet<>();
        for (int num : nums) {
            uniqueElements.add(num);
        }
        int requiredCount = uniqueElements.size();
        long result = 0;
        Map<Integer, Integer> countMap = new HashMap<>();
        int left = 0;

        for (int right = 0; right < n; right++) {
            countMap.put(nums[right], countMap.getOrDefault(nums[right], 0) + 1);
            while (countMap.size() == requiredCount) {
                result += n - right;
                countMap.put(nums[left], countMap.get(nums[left]) - 1);
                if (countMap.get(nums[left]) == 0) {
                    countMap.remove(nums[left]);
                }
                left++;
            }
        }
        return result;
    }
}