#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef long long ll;

ll mod = 1000000007;

ll pow_mod(ll a, ll b) {
    ll res = 1;
    while (b > 0) {
        if (b % 2 == 1)
            res = (res * a) % mod;
        a = (a * a) % mod;
        b /= 2;
    }
    return res;
}

ll count_ways(ll n, ll k) {
    ll ans = 1;
    for (ll i = 2; i * i <= n; i++) {
        ll cnt = 0;
        while (n % i == 0) {
            cnt++;
            n /= i;
        }
        if (cnt > 0) {
            ans = (ans * pow_mod(k, cnt)) % mod;
        }
    }
    if (n > 1) {
        ans = (ans * pow_mod(k, 1)) % mod;
    }
    return ans;
}

int numWays(int* nums, int numsSize) {
    ll product = 1;
    for (int i = 0; i < numsSize; i++) {
        product *= nums[i];
    }
    return (int)count_ways(product, numsSize);
}