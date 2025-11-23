typedef long long ll;

ll minNonZeroProduct(int p) {
    ll mod = 1e9 + 7;
    ll maxNum = (1LL << p) - 1;
    ll half = maxNum / 2;

    ll result = pow(maxNum, maxNum / 2) % mod;
    result = (result * (maxNum % mod)) % mod;

    return result;
}