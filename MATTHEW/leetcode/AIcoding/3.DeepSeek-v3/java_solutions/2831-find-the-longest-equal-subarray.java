class Solution {
    public int longestEqualSubarray(List<Integer> nums, int k) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < nums.size(); i++) {
            int num = nums.get(i);
            map.computeIfAbsent(num, key -> new ArrayList<>()).add(i);
        }

        int maxLen = 0;
        for (List<Integer> indices : map.values()) {
            int left = 0;
            for (int right = 0; right < indices.size(); right++) {
                while ((indices.get(right) - indices.get(left) - (right - left)) > k) {
                    left++;
                }
                maxLen = Math.max(maxLen, right - left + 1);
            }
        }
        return maxLen;
    }
}