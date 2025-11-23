import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private long getJumbledValue(int num, int[] mapping) {
        if (num == 0) {
            return mapping[0];
        }

        long jumbled = 0;
        long place = 1;

        int tempNum = num;
        while (tempNum > 0) {
            int digit = tempNum % 10;
            int mappedDigit = mapping[digit];
            jumbled = mappedDigit * place + jumbled;
            place *= 10;
            tempNum /= 10;
        }
        return jumbled;
    }

    public int[] sortJumbled(int[] mapping, int[] nums) {
        class JumbledNumber {
            int originalValue;
            long jumbledValue;
            int originalIndex;

            JumbledNumber(int originalValue, long jumbledValue, int originalIndex) {
                this.originalValue = originalValue;
                this.jumbledValue = jumbledValue;
                this.originalIndex = originalIndex;
            }
        }

        JumbledNumber[] jumbledNumbers = new JumbledNumber[nums.length];

        for (int i = 0; i < nums.length; i++) {
            int originalNum = nums[i];
            long jumbledNum = getJumbledValue(originalNum, mapping);
            jumbledNumbers[i] = new JumbledNumber(originalNum, jumbledNum, i);
        }

        Arrays.sort(jumbledNumbers, new Comparator<JumbledNumber>() {
            @Override
            public int compare(JumbledNumber a, JumbledNumber b) {
                if (a.jumbledValue != b.jumbledValue) {
                    return Long.compare(a.jumbledValue, b.jumbledValue);
                }
                return Integer.compare(a.originalIndex, b.originalIndex);
            }
        });

        int[] result = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            result[i] = jumbledNumbers[i].originalValue;
        }

        return result;
    }
}