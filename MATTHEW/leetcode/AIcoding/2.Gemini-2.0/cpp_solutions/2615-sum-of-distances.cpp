#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<long long> distance(vector<int>& arr) {
        int n = arr.size();
        vector<long long> ans(n, 0);
        vector<int> indices;
        int prev = -1;

        for (int i = 0; i < n; ++i) {
            if (i == 0 || arr[i] != arr[i - 1]) {
                if (!indices.empty()) {
                    long long sum = accumulate(indices.begin(), indices.end(), 0LL);
                    for (int j = 0; j < indices.size(); ++j) {
                        ans[indices[j]] = (long long)indices[j] * (j + 1) - sum + (sum - (long long)indices[j] * (indices.size() - j));
                    }
                }
                indices.clear();
            }
            indices.push_back(i);
        }

        if (!indices.empty()) {
            long long sum = accumulate(indices.begin(), indices.end(), 0LL);
            for (int j = 0; j < indices.size(); ++j) {
                ans[indices[j]] = (long long)indices[j] * (j + 1) - sum + (sum - (long long)indices[j] * (indices.size() - j));
            }
        }

        return ans;
    }
};