#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumBeauty(vector<int>& flowers, long long newFlowers, int target, int full, int partial) {
        int n = flowers.size();
        sort(flowers.begin(), flowers.end());

        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + min(flowers[i], target);
        }

        long long ans = 0;
        for (int numFull = 0; numFull <= n; ++numFull) {
            long long remainingFlowers = newFlowers;
            long long currentBeauty = (long long)numFull * full;

            if (numFull > 0) {
                for (int i = n - numFull; i < n; ++i) {
                    remainingFlowers -= max(0, target - flowers[i]);
                    if (remainingFlowers < 0) {
                        currentBeauty = 0;
                        break;
                    }
                }
            }

            if (currentBeauty == 0) continue;

            int left = 0, right = n - numFull - 1;
            long long bestPartial = 0;

            if (n - numFull > 0) {
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    long long needed = (long long)(mid + 1) * flowers[0] - (prefixSum[mid + 1]);
                    if (needed <= remainingFlowers) {
                        bestPartial = flowers[0];
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }

                long long low = 0, high = target - 1;
                long long actualBest = 0;

                while (low <= high) {
                    long long mid = low + (high - low) / 2;
                    int idx = upper_bound(flowers.begin(), flowers.begin() + n - numFull, mid) - flowers.begin();
                    long long needed = (long long)idx * mid - prefixSum[idx];
                    if (needed <= remainingFlowers) {
                        actualBest = mid;
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                bestPartial = actualBest;
            }

            ans = max(ans, currentBeauty + bestPartial * partial);
        }

        return ans;
    }
};