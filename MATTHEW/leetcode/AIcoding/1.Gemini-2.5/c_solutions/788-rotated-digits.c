int rotatedDigits(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int temp = i;
        int isValidRotation = 1; // 1 if all digits are valid for rotation
        int hasChangingDigit = 0; // 1 if at least one digit changes (2 or 5)

        while (temp > 0) {
            int digit = temp % 10;
            if (digit == 3 || digit == 4 || digit == 7) {
                isValidRotation = 0;
                break;
            }
            if (digit == 2 || digit == 5) {
                hasChangingDigit = 1;
            }
            temp /= 10;
        }

        if (isValidRotation && hasChangingDigit) {
            count++;
        }
    }
    return count;
}