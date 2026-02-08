import java.util.*;

class Solution {
    public int largestInteger(int num) {
        char[] digits = String.valueOf(num).toCharArray();
        List<Integer> odd = new ArrayList<>();
        List<Integer> even = new ArrayList<>();
        List<Boolean> isOdd = new ArrayList<>();

        for (char c : digits) {
            int digit = c - '0';
            if (digit % 2 == 1) {
                odd.add(digit);
                isOdd.add(true);
            } else {
                even.add(digit);
                isOdd.add(false);
            }
        }

        Collections.sort(odd, Collections.reverseOrder());
        Collections.sort(even, Collections.reverseOrder());

        int oddIndex = 0, evenIndex = 0;
        int result = 0;

        for (boolean b : isOdd) {
            if (b) {
                result = result * 10 + odd.get(oddIndex++);
            } else {
                result = result * 10 + even.get(evenIndex++);
            }
        }

        return result;
    }
}