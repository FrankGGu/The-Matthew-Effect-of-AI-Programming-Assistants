int earliestSecondToMarkIndices(int* nums, int numsSize, int* changeIndices, int changeIndicesSize) {
    int n = numsSize;
    int m = changeIndicesSize;

    for (int s = 1; s <= m; s++) {
        int last[n + 1];
        for (int i = 0; i <= n; i++) last[i] = -1;

        for (int i = 0; i < s; i++) {
            last[changeIndices[i]] = i;
        }

        int valid = 1;
        int operations = 0;
        for (int i = 0; i < s; i++) {
            int idx = changeIndices[i];
            if (last[idx] == i) {
                if (operations < nums[idx - 1]) {
                    valid = 0;
                    break;
                }
                operations -= nums[idx - 1];
            } else {
                operations++;
            }
        }

        if (valid) {
            int all_marked = 1;
            for (int i = 1; i <= n; i++) {
                if (last[i] == -1) {
                    all_marked = 0;
                    break;
                }
            }
            if (all_marked) {
                return s;
            }
        }
    }

    return -1;
}