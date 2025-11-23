class Solution {
    public int[] separateDigits(int[] nums) {
        List<Integer> digits = new ArrayList<>();
        for (int num : nums) {
            String s = Integer.toString(num);
            for (char c : s.toCharArray()) {
                digits.add(c - '0');
            }
        }
        int[] result = new int[digits.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = digits.get(i);
        }
        return result;
    }
}