class Solution {
    public int countDistinctIntegers(int[] nums) {
        Set<Integer> distinctNumbers = new HashSet<>();
        for (int num : nums) {
            distinctNumbers.add(num);
            int reversed = 0;
            while (num != 0) {
                reversed = reversed * 10 + num % 10;
                num /= 10;
            }
            distinctNumbers.add(reversed);
        }
        return distinctNumbers.size();
    }
}