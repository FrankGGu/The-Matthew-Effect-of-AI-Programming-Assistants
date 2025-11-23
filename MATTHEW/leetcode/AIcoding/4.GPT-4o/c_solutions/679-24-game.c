bool judgePoint24(int* nums, int numsSize) {
    if (numsSize == 0) return false;
    double numbers[4];
    for (int i = 0; i < numsSize; i++) {
        numbers[i] = (double)nums[i];
    }
    return dfs(numbers, numsSize);
}

bool dfs(double* nums, int size) {
    if (size == 1) {
        return fabs(nums[0] - 24.0) < 1e-6;
    }
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            if (i != j) {
                double newNums[4];
                int index = 0;
                for (int k = 0; k < size; k++) {
                    if (k != i && k != j) {
                        newNums[index++] = nums[k];
                    }
                }
                for (int op = 0; op < 4; op++) {
                    double res;
                    if (op == 0) res = nums[i] + nums[j];
                    else if (op == 1) res = nums[i] - nums[j];
                    else if (op == 2) res = nums[i] * nums[j];
                    else if (nums[j] != 0) res = nums[i] / nums[j];
                    else continue;
                    newNums[index] = res;
                    if (dfs(newNums, index + 1)) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}