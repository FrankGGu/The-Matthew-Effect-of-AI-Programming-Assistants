int countSymmetricIntegers(int low, int high) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        int num = i;
        int num_digits = 0;
        int temp = num;

        if (temp == 0) {
            num_digits = 1;
        } else {
            while (temp > 0) {
                temp /= 10;
                num_digits++;
            }
        }

        if (num_digits % 2 == 0) {
            int first_half_sum = 0;
            int second_half_sum = 0;
            int divisor = 1;

            for (int k = 0; k < num_digits / 2; k++) {
                divisor *= 10;
            }

            int first_half_num = num / divisor;
            int second_half_num = num % divisor;

            while (first_half_num > 0) {
                first_half_sum += first_half_num % 10;
                first_half_num /= 10;
            }

            while (second_half_num > 0) {
                second_half_sum += second_half_num % 10;
                second_half_num /= 10;
            }

            if (first_half_sum == second_half_sum) {
                count++;
            }
        }
    }
    return count;
}