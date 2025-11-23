class Solution {
    public String multiply(String num1, String num2) {
        if (num1.equals("0") || num2.equals("0")) {
            return "0";
        }
        int m = num1.length();
        int n = num2.length();
        int[] product = new int[m + n];

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                int digit1 = num1.charAt(i) - '0';
                int digit2 = num2.charAt(j) - '0';
                int p = digit1 * digit2;
                int p1 = i + j;
                int p2 = i + j + 1;
                int sum = p + product[p2];

                product[p2] = sum % 10;
                product[p1] += sum / 10;
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int digit : product) {
            if (!(sb.length() == 0 && digit == 0)) {
                sb.append(digit);
            }
        }

        return sb.toString();
    }
}