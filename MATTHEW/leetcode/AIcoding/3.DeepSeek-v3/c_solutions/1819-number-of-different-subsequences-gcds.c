int countDifferentSubsequenceGCDs(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* present = (int*)calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = 1;
    }

    int count = 0;
    for (int i = 1; i <= max_val; i++) {
        int g = 0;
        for (int j = i; j <= max_val; j += i) {
            if (present[j]) {
                g = gcd(g, j);
                if (g == i) {
                    count++;
                    break;
                }
            }
        }
    }

    free(present);
    return count;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}