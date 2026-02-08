class Solution {
    public int minimumOperations(int[] nums) {
        Set<Integer> uniqueElements = new HashSet<>();
        for (int num : nums) {
            if (num != 0) {
                uniqueElements.add(num);
            }
        }
        return uniqueElements.size();
    }
}