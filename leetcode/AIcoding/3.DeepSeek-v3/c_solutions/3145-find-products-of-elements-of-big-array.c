typedef long long ll;

ll countBits(ll n, ll k) {
    ll cnt = 0;
    for (ll i = k; i <= n; i <<= 1) {
        cnt += (n / (i << 1)) * i;
        cnt += fmax(0, n % (i << 1) - i + 1);
    }
    return cnt;
}

ll findKth(ll k) {
    ll left = 0, right = 1e15;
    while (left < right) {
        ll mid = left + (right - left) / 2;
        if (countBits(mid, 1) >= k + 1) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}

ll sumOfPowers(ll l, ll r, ll mod) {
    ll sum = 0;
    for (ll bit = 0; bit < 60; bit++) {
        ll power = 1LL << bit;
        ll cnt_r = countBits(r, power);
        ll cnt_l = countBits(l - 1, power);
        ll cnt = cnt_r - cnt_l;
        if (cnt % 2 == 1) {
            sum = (sum + power) % mod;
        }
    }
    return sum;
}

int* findProductsOfElements(long long** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        ll from = queries[i][0];
        ll to = queries[i][1];
        ll mod = queries[i][2];

        ll k1 = findKth(from);
        ll k2 = findKth(to);

        ll product = sumOfPowers(k1, k2, mod);
        result[i] = (int)product;
    }

    return result;
}