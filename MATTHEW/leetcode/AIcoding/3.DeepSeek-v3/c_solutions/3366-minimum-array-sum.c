int minArraySum(int* nums, int numsSize, int k, int op1, int op2) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int maxOps = op1 + op2;
    if (maxOps == 0) return sum;

    long long totalReduce = 0;

    for (int i = 0; i < numsSize; i++) {
        int val = nums[i];
        int maxReduce = 0;

        for (int op1Used = 0; op1Used <= op1 && op1Used * k <= val; op1Used++) {
            int remaining = val - op1Used * k;
            int op2Used = (remaining + 1) / 2;
            if (op2Used > op2) op2Used = op2;

            int reduce = op1Used * k + op2Used;
            if (reduce > maxReduce) maxReduce = reduce;
        }

        totalReduce += maxReduce;
    }

    return sum - totalReduce;
}