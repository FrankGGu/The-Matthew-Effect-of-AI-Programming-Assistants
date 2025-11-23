#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxRunTime(int n, vector<int>& batteries) {
        long long sum = 0;
        for (int battery : batteries) {
            sum += battery;
        }

        sort(batteries.begin(), batteries.end());

        int k = batteries.size() - n;
        long long extra = 0;
        for (int i = 0; i <= k; i++) {
            extra += batteries[i];
        }

        long long ans = batteries[k + 1];

        if (extra / (n) < ans) {
            ans = extra / (n);
        }

        long long l = 1;
        long long r = 1e14;
        long long res = 0;

        while(l <= r) {
            long long mid = l + (r - l) / 2;
            long long need = 0;
            for(int i = k + 1; i < batteries.size(); ++i) {
                need += min((long long)batteries[i], mid);
            }

            if(need >= mid * n) {
                res = mid;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        return res;
    }
};