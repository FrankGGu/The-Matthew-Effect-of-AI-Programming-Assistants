int maximumLength(int* nums, int numsSize) {
    int mod[3] = {0};
    for (int i = 0; i < numsSize; i++) {
        mod[nums[i] % 3]++;
    }

    int res = 0;

    if (mod[0] == 0) {
        res = fmin(mod[1], mod[2]) * 2;
        if (mod[1] > 0 && mod[2] > 0) res += 2;
        else res = fmax(res, fmin(mod[1], 1));
    } else if (mod[0] <= mod[1] + mod[2] + 1) {
        res = mod[0] * 2 + fmin(mod[1], mod[2]) * 2;
    } else {
        res = (mod[1] + mod[2]) * 2 + 1;
    }

    return res;
}