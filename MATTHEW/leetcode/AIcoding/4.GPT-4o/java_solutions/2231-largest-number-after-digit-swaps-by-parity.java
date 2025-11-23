import java.util.Arrays;

class Solution {
    public String largestInteger(int num) {
        char[] digits = Integer.toString(num).toCharArray();
        int[] odd = Arrays.stream(digits)
                          .filter(c -> (c - '0') % 2 != 0)
                          .map(c -> c - '0')
                          .sorted()
                          .toArray();
        int[] even = Arrays.stream(digits)
                           .filter(c -> (c - '0') % 2 == 0)
                           .map(c -> c - '0')
                           .sorted()
                           .toArray();

        StringBuilder result = new StringBuilder();
        int oddIndex = odd.length - 1, evenIndex = even.length - 1;

        for (char digit : digits) {
            if ((digit - '0') % 2 == 0) {
                result.append(evenIndex >= 0 ? even[evenIndex--] : "");
            } else {
                result.append(oddIndex >= 0 ? odd[oddIndex--] : "");
            }
        }

        return result.toString();
    }
}