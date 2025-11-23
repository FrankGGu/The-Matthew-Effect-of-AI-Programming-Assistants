public class Solution {
    public int sumDigits(String s) {
        int sum = 0;
        for (char c : s.toCharArray()) {
            int digit = c - 'a' + 1;
            sum += digit;
        }
        return sum;
    }
}