#include <vector>
#include <algorithm>

using namespace std;

const int MOD = 1e9 + 7;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long inverse(long long n) {
    return power(n, MOD - 2);
}

long long combinations(int n, int k, vector<long long>& fact, vector<long long>& inv_fact) {
    if (k < 0 || k > n) return 0;
    return (((fact[n] * inv_fact[k]) % MOD) * inv_fact[n - k]) % MOD;
}

```
```cpp
#include <vector>
#include <numeric>

using namespace std;

const int MOD = 1e9 + 7;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long inverse(long long n) {
    return power(n, MOD - 2);
}

int findTheNumberOfWays(vector<int>& balls) {
    int m = balls.size();
    int n = accumulate(balls.begin(), balls.end(), 0);

    vector<long long> fact(n + 1);
    fact[0] = 1;
    for (int i = 1; i <= n; ++i) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    long long ans = fact[n];
    for (int ball : balls) {
        ans = (ans * inverse(fact[ball])) % MOD;
    }

    return (int)ans;
}
```
```cpp
#include <vector>
#include <numeric>

using namespace std;

const int MOD = 1e9 + 7;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long inverse(long long n) {
    return power(n, MOD - 2);
}

int findTheNumberOfWays(vector<int>& balls) {
    int totalBalls = accumulate(balls.begin(), balls.end(), 0);
    vector<long long> fact(totalBalls + 1);
    fact[0] = 1;
    for (int i = 1; i <= totalBalls; ++i) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    long long result = fact[totalBalls];
    for (int ballCount : balls) {
        result = (result * inverse(fact[ballCount])) % MOD;
    }

    return (int)result;
}