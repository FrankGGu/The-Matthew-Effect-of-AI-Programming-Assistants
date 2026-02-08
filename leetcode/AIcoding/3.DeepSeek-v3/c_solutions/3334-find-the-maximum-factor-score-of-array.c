typedef long long ll;

int cmp(const void* a, const void* b) {
    return *(ll*)a - *(ll*)b;
}

ll maxScore(int* nums, int numsSize) {
    ll* arr = (ll*)malloc(numsSize * sizeof(ll));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
    }
    qsort(arr, numsSize, sizeof(ll), cmp);

    ll gcd_val = arr[0];
    ll lcm_val = arr[0];
    for (int i = 1; i < numsSize; i++) {
        ll a = lcm_val;
        ll b = arr[i];
        ll temp = gcd_val;
        gcd_val = gcd(gcd_val, b);

        ll g = gcd(a, b);
        lcm_val = a / g * b;
    }

    ll max_score = gcd_val * lcm_val;
    free(arr);
    return max_score;
}

ll gcd(ll a, ll b) {
    while (b != 0) {
        ll temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}