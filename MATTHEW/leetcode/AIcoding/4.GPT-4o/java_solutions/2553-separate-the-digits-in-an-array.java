class Solution {
    public int[] separateDigits(int[] nums) {
        StringBuilder sb = new StringBuilder();
        for (int num : nums) {
            sb.append(num);
        }
        int[] result = new int[sb.length()];
        for (int i = 0; i < sb.length(); i++) {
            result[i] = sb.charAt(i) - '0';
        }
        return result;
    }
}