class Solution {
    public String multiply(String num1, String num2) {
        if ("0".equals(num1) || "0".equals(num2)) {
            return "0";
        }

        int m = num1.length();
        int n = num2.length();
        int[] res = new int[m + n];

        // Iterate from right to left for both numbers
        for (int i = m - 1; i >= 0; i--) {
            int digit1 = num1.charAt(i) - '0';
            for (int j = n - 1; j >= 0; j--) {
                int digit2 = num2.charAt(j) - '0';

                // Calculate product and add to the corresponding positions
                // pos1 will be the tens place, pos2 will be the units place
                int pos1 = i + j;
                int pos2 = i + j + 1;

                int product = digit1 * digit2;
                int sum = product + res[pos2]; // Add existing value/carry at pos2

                res[pos2] = sum % 10; // Units digit
                res[pos1] += sum / 10; // Carry to the tens place
            }
        }

        StringBuilder sb = new StringBuilder();
        int i = 0;
        // Skip leading zeros
        while (i < res.length - 1 && res[i] == 0) { // Keep at least one zero if result is "0"
            i++;
        }

        // Append digits to StringBuilder
        for (; i < res.length; i++) {
            sb.append(res[i]);
        }

        return sb.toString();
    }
}