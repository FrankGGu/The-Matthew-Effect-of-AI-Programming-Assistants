import java.util.Arrays;

class Solution {
    public String largestNumberAfterDigitSwaps(String num) {
        int n = num.length();
        Integer[] even = new Integer[n];
        Integer[] odd = new Integer[n];
        int evenCount = 0;
        int oddCount = 0;

        for (int i = 0; i < n; i++) {
            int digit = num.charAt(i) - '0';
            if (digit % 2 == 0) {
                even[evenCount++] = digit;
            } else {
                odd[oddCount++] = digit;
            }
        }

        even = Arrays.copyOf(even, evenCount);
        odd = Arrays.copyOf(odd, oddCount);
        Arrays.sort(even, (a, b) -> b - a);
        Arrays.sort(odd, (a, b) -> b - a);

        StringBuilder result = new StringBuilder();
        int evenIndex = 0;
        int oddIndex = 0;
        for (int i = 0; i < n; i++) {
            int digit = num.charAt(i) - '0';
            if (digit % 2 == 0) {
                result.append(even[evenIndex++]);
            } else {
                result.append(odd[oddIndex++]);
            }
        }

        return result.toString();
    }
}