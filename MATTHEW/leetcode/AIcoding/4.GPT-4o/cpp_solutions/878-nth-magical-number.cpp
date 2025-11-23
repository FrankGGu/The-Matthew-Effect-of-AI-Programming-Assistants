class Solution {
public:
    int nthMagicalNumber(int n, int a, int b) {
        long long lcm = (long long)a * b / gcd(a, b);
        long long mod = 1e9 + 7;
        long long count = lcm / a + lcm / b;
        long long k = n / count;
        long long ans = (k * lcm) % mod;
        n %= count;

        priority_queue<long long, vector<long long>, greater<long long>> pq;
        pq.push(a);
        pq.push(b);

        while (n > 0) {
            long long curr = pq.top();
            pq.pop();
            ans = (ans + curr) % mod;
            n--;
            pq.push(curr + a);
            pq.push(curr + b);
        }

        return ans;
    }
};