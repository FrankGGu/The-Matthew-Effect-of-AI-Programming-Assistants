typedef struct {
    long long val;
    int idx;
} Pair;

int cmp(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    if (pa->val == pb->val) {
        return pa->idx - pb->idx;
    }
    return pa->val > pb->val ? 1 : -1;
}

long long minimumCost(int* nums, int numsSize, int k, int dist) {
    long long res = 1e18;
    long long sum = 0;
    int left = 0, right = 0;
    Pair* arr = (Pair*)malloc(numsSize * sizeof(Pair));
    int* taken = (int*)calloc(numsSize, sizeof(int));

    for (int i = 1; i < numsSize; i++) {
        arr[i].val = nums[i];
        arr[i].idx = i;
    }

    qsort(arr + 1, numsSize - 1, sizeof(Pair), cmp);

    int* pos = (int*)malloc(numsSize * sizeof(int));
    for (int i = 1; i < numsSize; i++) {
        pos[arr[i].idx] = i;
    }

    for (int i = 1; i <= k - 1; i++) {
        taken[pos[i]] = 1;
        sum += arr[pos[i]].val;
        if (arr[pos[i]].idx > right) right = arr[pos[i]].idx;
    }

    for (int l = 1, r = k; r < numsSize; l++, r++) {
        if (l > 1) {
            int p = pos[l - 1];
            if (taken[p]) {
                taken[p] = 0;
                sum -= arr[p].val;
            }
        }

        int p = pos[r];
        if (!taken[p]) {
            taken[p] = 1;
            sum += arr[p].val;
        }

        while (right - l + 1 > dist) {
            int candidate = -1;
            for (int i = right; i >= l; i--) {
                if (taken[pos[i]]) {
                    candidate = pos[i];
                    break;
                }
            }
            if (candidate != -1) {
                taken[candidate] = 0;
                sum -= arr[candidate].val;
                right--;
            } else {
                right--;
            }
        }

        while (right - l + 1 < dist && right < numsSize - 1) {
            right++;
            if (!taken[pos[right]]) {
                taken[pos[right]] = 1;
                sum += arr[pos[right]].val;
            }
        }

        int count = 0;
        for (int i = 1; i < numsSize; i++) {
            if (taken[i]) count++;
        }
        if (count >= k - 1) {
            long long curr = nums[0] + sum;
            if (curr < res) res = curr;
        }
    }

    free(arr);
    free(taken);
    free(pos);
    return res;
}