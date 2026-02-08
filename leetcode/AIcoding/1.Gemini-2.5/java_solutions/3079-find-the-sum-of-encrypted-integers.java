import java.util.List;

class Solution {
    public int sumOfEncryptedInt(int[] nums) {
        int totalSum = 0;
        for (int num : nums) {
            if (num == 0) { // Handle case for 0 if it can appear. Encrypted 0 is 0.
                totalSum += 0;
                continue;
            }

            int temp = num;
            int maxDigit = 0;
            int numDigits = 0;

            while (temp > 0) {
                int digit = temp % 10;
                maxDigit = Math.max(maxDigit, digit);
                numDigits++;
                temp /= 10;
            }

            int encryptedValue = 0;
            for (int i = 0; i < numDigits; i++) {
                encryptedValue = encryptedValue * 10 + maxDigit;
            }
            totalSum += encryptedValue;
        }
        return totalSum;
    }
}