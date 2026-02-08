class Solution {
    public int minimumOperations(int[] nums) {
        Set<Integer> distinctPositive = new HashSet<>();
        for (int num : nums) {
            if (num > 0) {
                distinctPositive.add(num);
            }
        }
        return distinctPositive.size();
    }
}