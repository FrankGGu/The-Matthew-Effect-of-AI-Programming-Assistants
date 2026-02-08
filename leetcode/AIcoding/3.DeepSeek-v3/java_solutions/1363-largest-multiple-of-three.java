class Solution {
    public String largestMultipleOfThree(int[] digits) {
        int[] count = new int[10];
        int sum = 0;
        for (int d : digits) {
            count[d]++;
            sum += d;
        }

        if (sum % 3 == 1) {
            if (!removeDigits(count, 1, 1)) {
                removeDigits(count, 2, 2);
            }
        } else if (sum % 3 == 2) {
            if (!removeDigits(count, 2, 1)) {
                removeDigits(count, 1, 2);
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 9; i >= 0; i--) {
            while (count[i]-- > 0) {
                sb.append(i);
            }
        }

        if (sb.length() > 0 && sb.charAt(0) == '0') {
            return "0";
        }
        return sb.toString();
    }

    private boolean removeDigits(int[] count, int remainder, int num) {
        for (int i = remainder; i < 10; i += 3) {
            if (count[i] >= num) {
                count[i] -= num;
                return true;
            }
        }
        return false;
    }
}