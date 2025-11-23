typedef long long ll;

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

long long maximumBeauty(int* flowers, int flowersSize, long long newFlowers, int target, int full, int partial) {
    qsort(flowers, flowersSize, sizeof(int), cmp);

    ll pre[flowersSize + 1];
    pre[0] = 0;
    for (int i = 0; i < flowersSize; i++) {
        pre[i + 1] = pre[i] + flowers[i];
    }

    ll ans = 0;
    int j = flowersSize - 1;
    while (j >= 0 && flowers[j] >= target) {
        j--;
    }

    for (int k = flowersSize; k >= 0; k--) {
        if (k > 0) {
            ll needed = (ll)target * k - (pre[flowersSize] - pre[flowersSize - k]);
            if (needed > newFlowers) {
                continue;
            }
        }

        ll rem = newFlowers;
        if (k > 0) {
            rem -= (ll)target * k - (pre[flowersSize] - pre[flowersSize - k]);
        }

        if (j + 1 >= flowersSize - k) {
            j = flowersSize - k - 1;
        }
        if (j < 0) {
            ans = (ll)full * k > ans ? (ll)full * k : ans;
            continue;
        }

        int lo = 0, hi = target - 1;
        while (lo < hi) {
            int mid = (lo + hi + 1) / 2;
            int idx = -1;
            int left = 0, right = j;
            while (left <= right) {
                int m = (left + right) / 2;
                if (flowers[m] < mid) {
                    idx = m;
                    left = m + 1;
                } else {
                    right = m - 1;
                }
            }
            if (idx == -1) {
                hi = mid - 1;
                continue;
            }
            ll need = (ll)mid * (idx + 1) - pre[idx + 1];
            if (need <= rem) {
                lo = mid;
            } else {
                hi = mid - 1;
            }
        }

        ll cur = (ll)full * k + (ll)partial * lo;
        ans = cur > ans ? cur : ans;
    }

    return ans;
}