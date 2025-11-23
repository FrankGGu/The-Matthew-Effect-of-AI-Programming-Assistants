class Solution {
    public int minImpossibleOR(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int res = 1;
        while (set.contains(res)) {
            res <<= 1;
        }
        return res;
    }
}