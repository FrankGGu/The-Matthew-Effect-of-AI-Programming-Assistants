#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

long long makeSubKSumEqual(vector<int>& arr, int k) {
    int n = arr.size();
    k = gcd(n, k);
    long long ans = 0;
    for (int i = 0; i < k; ++i) {
        vector<int> sub;
        for (int j = i; j < n; j += k) {
            sub.push_back(arr[j]);
        }
        sort(sub.begin(), sub.end());
        int median = sub[sub.size() / 2];
        for (int num : sub) {
            ans += abs(num - median);
        }
    }
    return ans;
}

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}