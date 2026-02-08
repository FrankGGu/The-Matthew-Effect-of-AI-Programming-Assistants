class Solution {
    public String largestNumber(String num, int[] change) {
        char[] digits = num.toCharArray();
        boolean startedMutating = false;

        for (int i = 0; i < digits.length; i++) {
            int originalDigit = digits[i] - '0';
            int changedDigit = change[originalDigit];

            if (changedDigit > originalDigit) {
                startedMutating = true;
                digits[i] = (char) (changedDigit + '0');
            } else if (changedDigit == originalDigit) {
                if (startedMutating) {
                    digits[i] = (char) (changedDigit + '0');
                }
            } else { // changedDigit < originalDigit
                if (startedMutating) {
                    break; 
                }
            }
        }

        return new String(digits);
    }
}