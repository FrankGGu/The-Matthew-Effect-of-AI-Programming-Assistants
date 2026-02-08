#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<long long> getDistances(vector<int>& arr) {
        unordered_map<int, vector<int>> indices;
        int n = arr.size();
        vector<long long> result(n, 0);

        for (int i = 0; i < n; ++i) {
            indices[arr[i]].push_back(i);
        }

        for (auto& [num, idx_list] : indices) {
            int k = idx_list.size();
            vector<long long> prefix_sum(k + 1, 0);
            for (int i = 0; i < k; ++i) {
                prefix_sum[i + 1] = prefix_sum[i] + idx_list[i];
            }

            for (int i = 0; i < k; ++i) {
                long long left_sum = (long long)idx_list[i] * i - prefix_sum[i];
                long long right_sum = (prefix_sum[k] - prefix_sum[i + 1]) - (long long)idx_list[i] * (k - i - 1);
                result[idx_list[i]] = left_sum + right_sum;
            }
        }

        return result;
    }
};