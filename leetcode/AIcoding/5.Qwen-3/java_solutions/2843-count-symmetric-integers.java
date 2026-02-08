public class Solution {
    public int countSymmetricIntegers(int[] nums) {
        int count = 0;
        for (int num : nums) {
            String s = String.valueOf(num);
            if (s.length() % 2 != 0) continue;
            int half = s.length() / 2;
            String left = s.substring(0, half);
            String right = s.substring(half);
            if (left.equals(new StringBuilder(right).reverse().toString())) {
                count++;
            }
        }
        return count;
    }
}