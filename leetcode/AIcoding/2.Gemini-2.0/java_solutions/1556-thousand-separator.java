class Solution {
    public String thousandSeparator(int n) {
        if (n == 0) {
            return "0";
        }
        StringBuilder sb = new StringBuilder();
        int count = 0;
        while (n > 0) {
            sb.append(n % 10);
            n /= 10;
            count++;
            if (count % 3 == 0 && n > 0) {
                sb.append('.');
            }
        }
        return sb.reverse().toString();
    }
}