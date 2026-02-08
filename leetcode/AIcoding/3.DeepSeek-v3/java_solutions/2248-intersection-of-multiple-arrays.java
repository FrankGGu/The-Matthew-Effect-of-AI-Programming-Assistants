class Solution {
    public List<Integer> intersection(int[][] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int[] arr : nums) {
            for (int num : arr) {
                countMap.put(num, countMap.getOrDefault(num, 0) + 1);
            }
        }
        List<Integer> result = new ArrayList<>();
        int n = nums.length;
        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            if (entry.getValue() == n) {
                result.add(entry.getKey());
            }
        }
        Collections.sort(result);
        return result;
    }
}