import java.util.Arrays;

public class Solution {
    public String largestMultipleOfThree(int[] digits) {
        Arrays.sort(digits);
        int sum = 0;
        for (int digit : digits) {
            sum += digit;
        }

        if (sum % 3 == 0) {
            return buildResult(digits);
        } else if (sum % 3 == 1) {
            return removeOneOrTwo(digits, 1);
        } else {
            return removeOneOrTwo(digits, 2);
        }
    }

    private String removeOneOrTwo(int[] digits, int mod) {
        int[] count = new int[10];
        for (int digit : digits) {
            count[digit]++;
        }

        if (mod == 1) {
            for (int i = 1; i < 10; i += 3) {
                if (count[i] > 0) {
                    count[i]--;
                    return buildResult(count);
                }
            }
            for (int i = 2; i < 10; i += 3) {
                if (count[i] > 1) {
                    count[i] -= 2;
                    return buildResult(count);
                }
            }
        } else {
            for (int i = 2; i < 10; i += 3) {
                if (count[i] > 0) {
                    count[i]--;
                    return buildResult(count);
                }
            }
            for (int i = 1; i < 10; i += 3) {
                if (count[i] > 1) {
                    count[i] -= 2;
                    return buildResult(count);
                }
            }
        }
        return "";
    }

    private String buildResult(int[] count) {
        StringBuilder result = new StringBuilder();
        for (int i = 9; i >= 0; i--) {
            while (count[i]-- > 0) {
                result.append(i);
            }
        }
        if (result.length() == 0 || result.charAt(0) == '0') {
            return "0";
        }
        return result.toString();
    }
}