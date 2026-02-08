public class Solution {
    public String convertToBase7(int num) {
        if (num == 0) {
            return "0";
        }
        boolean negative = num < 0;
        if (negative) {
            num = -num;
        }
        StringBuilder sb = new StringBuilder();
        while (num > 0) {
            sb.insert(0, num % 7);
            num /= 7;
        }
        if (negative) {
            sb.insert(0, '-');
        }
        return sb.toString();
    }
}