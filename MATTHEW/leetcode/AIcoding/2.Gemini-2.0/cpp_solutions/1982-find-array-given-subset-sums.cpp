#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> recoverArray(int n, vector<int>& sums) {
        sort(sums.begin(), sums.end());
        vector<int> res;
        for (int i = 0; i < n; ++i) {
            int diff = sums[1] - sums[0];
            vector<int> positive, negative;
            int count = 0;
            for (int j = 0; j < sums.size(); ++j) {
                if (count == 0) {
                    positive.push_back(sums[j]);
                    if (find(sums.begin() + j + 1, sums.end(), sums[j] + diff) != sums.end()) {
                        sums.erase(find(sums.begin() + j + 1, sums.end(), sums[j] + diff));
                        count++;
                    } else {
                        negative.push_back(sums[j]);
                    }
                } else {
                  negative.push_back(sums[j]);
                  count--;
                }
            }

            if (positive[0] == 0) {
                res.push_back(diff);
                sums = positive;
            } else {
                res.push_back(-diff);
                sums = negative;
            }
        }
        return res;
    }
};