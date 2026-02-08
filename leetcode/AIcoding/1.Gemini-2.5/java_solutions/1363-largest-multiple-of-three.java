import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public String largestMultipleOfThree(int[] digits) {
        int[] counts = new int[10];
        int sum = 0;
        for (int digit : digits) {
            counts[digit]++;
            sum += digit;
        }

        int remainder = sum % 3;

        if (remainder == 1) {
            boolean removedOneMod1 = false;
            for (int d = 1; d <= 7; d += 3) {
                if (counts[d] > 0) {
                    counts[d]--;
                    removedOneMod1 = true;
                    break;
                }
            }

            if (!removedOneMod1) {
                int removedCountMod2 = 0;
                for (int d = 2; d <= 8; d += 3) {
                    if (counts[d] > 0) {
                        counts[d]--;
                        removedCountMod2++;
                        if (removedCountMod2 == 2) break;
                    }
                }
            }
        } else if (remainder == 2) {
            boolean removedOneMod2 = false;
            for (int d = 2; d <= 8; d += 3) {
                if (counts[d] > 0) {
                    counts[d]--;
                    removedOneMod2 = true;
                    break;
                }
            }

            if (!removedOneMod2) {
                int removedCountMod1 = 0;
                for (int d = 1; d <= 7; d += 3) {
                    if (counts[d] > 0) {
                        counts[d]--;
                        removedCountMod1++;
                        if (removedCountMod1 == 2) break;
                    }
                }
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int d = 9; d >= 0; d--) {
            for (int i = 0; i < counts[d]; i++) {
                sb.append(d);
            }
        }

        if (sb.length() == 0) {
            return "";
        }

        if (sb.charAt(0) == '0') {
            return "0";
        }

        return sb.toString();
    }
}