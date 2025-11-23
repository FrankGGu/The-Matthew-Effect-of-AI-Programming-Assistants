char* largestMultipleOfThree(int* digits, int digitsSize) {
    int count[10] = {0}, sum = 0;
    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
        sum += digits[i];
    }
    int remainder = sum % 3;
    if (remainder != 0) {
        for (int i = remainder; i < 10; i += 3) {
            if (count[i] > 0) {
                count[i]--;
                break;
            }
        }
        if (count[remainder] == 0) {
            for (int i = 0; i < 10; i++) {
                if (count[i] > 1) {
                    count[i] -= 2;
                    break;
                }
            }
        }
    }
    char* result = (char*)malloc(digitsSize + 1);
    int index = 0;
    for (int i = 9; i >= 0; i--) {
        while (count[i] > 0) {
            result[index++] = i + '0';
            count[i]--;
        }
    }
    if (index == 0 || (index == 1 && result[0] == '0')) {
        result[0] = '0';
        index = 1;
    }
    result[index] = '\0';
    return result;
}