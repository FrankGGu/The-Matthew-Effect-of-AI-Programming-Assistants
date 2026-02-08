import java.util.Arrays;

class Solution {
    public int maxDiff(int num) {
        char[] s = String.valueOf(num).toCharArray();

        // Calculate max_val
        char[] max_s = Arrays.copyOf(s, s.length);
        char digitToChangeForMax = ' ';
        for (int i = 0; i < max_s.length; i++) {
            if (max_s[i] != '9') {
                digitToChangeForMax = max_s[i];
                break;
            }
        }
        if (digitToChangeForMax != ' ') { 
            for (int i = 0; i < max_s.length; i++) {
                if (max_s[i] == digitToChangeForMax) {
                    max_s[i] = '9';
                }
            }
        }
        int max_val = Integer.parseInt(new String(max_s));

        // Calculate min_val
        char[] min_s = Arrays.copyOf(s, s.length);
        char digitToChangeForMin = ' ';
        char targetDigitForMin = ' ';

        if (min_s[0] != '1') {
            digitToChangeForMin = min_s[0];
            targetDigitForMin = '1';
        } else { 
            for (int i = 1; i < min_s.length; i++) { 
                if (min_s[i] != '0' && min_s[i] != '1') {
                    digitToChangeForMin = min_s[i];
                    targetDigitForMin = '0';
                    break;
                }
            }
        }

        if (digitToChangeForMin != ' ') { 
            for (int i = 0; i < min_s.length; i++) {
                if (min_s[i] == digitToChangeForMin) {
                    min_s[i] = targetDigitForMin;
                }
            }
        }
        int min_val = Integer.parseInt(new String(min_s));

        return max_val - min_val;
    }
}