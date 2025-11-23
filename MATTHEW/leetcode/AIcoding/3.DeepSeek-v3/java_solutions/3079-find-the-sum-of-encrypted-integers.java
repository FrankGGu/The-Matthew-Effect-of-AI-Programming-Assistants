class Solution {
    public int sumOfEncryptedInt(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += encrypt(num);
        }
        return sum;
    }

    private int encrypt(int num) {
        int maxDigit = 0;
        int count = 0;
        int temp = num;
        while (temp > 0) {
            int digit = temp % 10;
            if (digit > maxDigit) {
                maxDigit = digit;
            }
            temp /= 10;
            count++;
        }
        int encrypted = 0;
        for (int i = 0; i < count; i++) {
            encrypted = encrypted * 10 + maxDigit;
        }
        return encrypted;
    }
}