typedef long long ll;

int countNonDecreasingSubarrays(int* nums, int numsSize, int k) {
    ll res = 0;
    int left = 0;
    ll sum = 0;

    for (int right = 0; right < numsSize; right++) {
        if (right > 0 && nums[right] < nums[right - 1]) {
            left = right;
            sum = 0;
        }

        int len = right - left + 1;
        sum += len;
        res += sum;
    }

    if (k == 0) return res;

    int* temp = (int*)malloc(numsSize * sizeof(int));
    memcpy(temp, nums, numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        memcpy(nums, temp, numsSize * sizeof(int));

        for (int j = i; j < numsSize; j++) {
            nums[j] += k;

            ll cnt = 0;
            int l = i;
            ll s = 0;

            for (int r = i; r <= j; r++) {
                if (r > i && nums[r] < nums[r - 1]) {
                    l = r;
                    s = 0;
                }

                int ln = r - l + 1;
                s += ln;
                cnt += s;
            }

            res = (res > cnt) ? res : cnt;
        }
    }

    free(temp);
    return res;
}