int calculate_gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int minimizeArrayLength(int* nums, int numsSize) {
    int overall_gcd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        overall_gcd = calculate_gcd(overall_gcd, nums[i]);
    }

    int count_overall_gcd_elements = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == overall_gcd) {
            count_overall_gcd_elements++;
        }
    }

    if (count_overall_gcd_elements == 0) {
        return 1;
    } else {
        return count_overall_gcd_elements % 2;
    }
}