public class Solution {
    public String findMaximumBinaryString(String binary) {
        int n = binary.length();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = binary.charAt(i) - '0';
        }

        int zeros = 0;
        int ones = 0;
        int firstZero = -1;

        for (int i = 0; i < n; i++) {
            if (arr[i] == 0) {
                zeros++;
                if (firstZero == -1) {
                    firstZero = i;
                }
            } else {
                ones++;
            }
        }

        if (zeros <= 1) {
            return binary;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < firstZero; i++) {
            sb.append('1');
        }

        int k = zeros - 1;
        for (int i = 0; i < k; i++) {
            sb.append('0');
        }

        for (int i = firstZero + zeros; i < n; i++) {
            sb.append('1');
        }

        return sb.toString();
    }
}