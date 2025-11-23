typedef long long ll;

int closestToTarget(int* arr, int arrSize, int k) {
    ll ans = 1e18;
    for (int i = 0; i < arrSize; i++) {
        ll cur = arr[i];
        for (int j = i; j < arrSize; j++) {
            cur |= arr[j];
            ll diff = llabs(cur - k);
            if (diff < ans) ans = diff;
            if (ans == 0) return 0;
            if (cur >= k) break;
        }
    }
    return (int)ans;
}