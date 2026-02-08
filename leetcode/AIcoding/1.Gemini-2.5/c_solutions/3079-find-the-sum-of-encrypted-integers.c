int sumOfEncryptedInt(int* nums, int numsSize) {
    long long total_sum = 0;

    for (int i = 0; i < numsSize; i++) {
        int current_num = nums[i];

        int max_digit = 0;
        int digit_count = 0;
        int temp_num = current_num;

        // Find the maximum digit and count the number of digits
        while (temp_num > 0) {
            int digit = temp_num % 10;
            if (digit > max_digit) {
                max_digit = digit;
            }
            digit_count++;
            temp_num /= 10;
        }

        // Construct the encrypted number by repeating the max_digit
        int encrypted_num = 0;
        for (int j = 0; j < digit_count; j++) {
            encrypted_num = encrypted_num * 10 + max_digit;
        }

        total_sum += encrypted_num;
    }

    return (int)total_sum;
}