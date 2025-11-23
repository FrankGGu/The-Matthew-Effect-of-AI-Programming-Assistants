#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minWastedSpace(vector<int>& packages, vector<vector<int>>& boxes) {
        const int MOD = 1e9 + 7;
        sort(packages.begin(), packages.end());
        long long totalSum = 0;
        for (int p : packages) {
            totalSum += p;
        }

        long long minWaste = LLONG_MAX;

        for (auto& box : boxes) {
            sort(box.begin(), box.end());
            if (box.back() < packages.back()) {
                continue;
            }

            long long currSum = 0;
            int prev = 0;
            for (int b : box) {
                auto it = upper_bound(packages.begin(), packages.end(), b);
                int cnt = it - packages.begin() - prev;
                if (cnt > 0) {
                    currSum += (long long)b * cnt;
                }
                prev = it - packages.begin();
                if (prev == packages.size()) {
                    break;
                }
            }

            long long waste = currSum - totalSum;
            if (waste < minWaste) {
                minWaste = waste;
            }
        }

        return minWaste == LLONG_MAX ? -1 : minWaste % MOD;
    }
};