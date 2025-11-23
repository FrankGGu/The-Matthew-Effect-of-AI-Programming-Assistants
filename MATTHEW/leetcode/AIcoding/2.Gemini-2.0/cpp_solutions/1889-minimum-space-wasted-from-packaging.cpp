#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minWastedSpace(vector<int>& packages, vector<vector<int>>& boxes) {
        const int MOD = 1e9 + 7;
        sort(packages.begin(), packages.end());
        long long minWaste = -1;

        for (const auto& boxSizes : boxes) {
            vector<int> boxSizesCopy = boxSizes;
            sort(boxSizesCopy.begin(), boxSizesCopy.end());

            if (boxSizesCopy.back() < packages.back()) {
                continue;
            }

            long long currentWaste = 0;
            int packageIndex = 0;

            for (int i = 0; i < boxSizesCopy.size(); ++i) {
                if (packages[packageIndex] <= boxSizesCopy[i]) {
                    int lastIndex = packageIndex;
                    while (lastIndex < packages.size() && packages[lastIndex] <= boxSizesCopy[i]) {
                        lastIndex++;
                    }
                    currentWaste = (currentWaste + (long long)(lastIndex - packageIndex) * boxSizesCopy[i]) % MOD;
                    packageIndex = lastIndex;
                }

                if (packageIndex == packages.size()) {
                    break;
                }
            }

            for(int p : packages) {
                currentWaste = (currentWaste - p + MOD) % MOD;
            }

            if (minWaste == -1 || currentWaste < minWaste) {
                minWaste = currentWaste;
            }
        }

        return minWaste;
    }
};