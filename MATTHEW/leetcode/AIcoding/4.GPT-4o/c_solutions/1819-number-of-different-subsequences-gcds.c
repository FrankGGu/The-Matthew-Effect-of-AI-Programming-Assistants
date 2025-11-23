int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int countDifferentGCDs(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    bool present[maxNum + 1];
    for (int i = 0; i <= maxNum; i++) {
        present[i] = false;
    }

    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = true;
    }

    int count = 0;
    for (int g = 1; g <= maxNum; g++) {
        int currentGCD = 0;
        for (int multiple = g; multiple <= maxNum; multiple += g) {
            if (present[multiple]) {
                currentGCD = gcd(currentGCD, multiple);
            }
        }
        if (currentGCD == g) {
            count++;
        }
    }

    return count;
}