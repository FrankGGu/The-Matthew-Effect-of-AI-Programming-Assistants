int minimalKSum(int* nums, int numsSize, int k) {
    long long sum = 0;
    int count = 0;
    int i = 0, current = 1;
    int seen[100001] = {0};

    for (i = 0; i < numsSize; i++) {
        if (nums[i] <= 100000) {
            seen[nums[i]] = 1;
        }
    }

    while (k > 0) {
        if (!seen[current]) {
            sum += current;
            k--;
        }
        current++;
    }

    return sum;
}