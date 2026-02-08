#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long maxPower(vector<int>& stations, int r, int k) {
        int n = stations.size();
        long long left = 0, right = 2e14;
        long long ans = 0;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            if (check(stations, r, k, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }

private:
    bool check(vector<int>& stations, int r, int k, long long power) {
        int n = stations.size();
        vector<long long> diff(n, 0);
        long long currentSum = 0;
        long long need = 0;

        for (int i = 0; i < n; ++i) {
            currentSum += (i > 0 ? diff[i - 1] : 0);
            long long currentPower = stations[i] + currentSum;

            if (currentPower < power) {
                long long add = power - currentPower;
                need += add;
                if (need > k) {
                    return false;
                }
                currentSum += add;
                diff[i] = add;
                if (i + 2 * r + 1 < n) {
                  diff[i + 2 * r + 1] = -add;
                }
            } else {
                if (i + 2 * r + 1 < n) {
                  diff[i + 2 * r + 1] = 0;
                }
            }
        }

        return true;
    }
};