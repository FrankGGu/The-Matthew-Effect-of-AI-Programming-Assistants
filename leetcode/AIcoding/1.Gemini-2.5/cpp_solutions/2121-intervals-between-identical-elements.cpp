#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<long long> getDistances(std::vector<int>& arr) {
        int n = arr.size();
        std::vector<long long> ans(n);

        std::unordered_map<int, long long> sum_indices;
        std::unordered_map<int, int> count;

        for (int i = 0; i < n; ++i) {
            int val = arr[i];
            ans[i] += (long long)count[val] * i - sum_indices[val];
            count[val]++;
            sum_indices[val] += i;
        }

        sum_indices.clear();
        count.clear();

        for (int i = n - 1; i >= 0; --i) {
            int val = arr[i];
            ans[i] += sum_indices[val] - (long long)count[val] * i;
            count[val]++;
            sum_indices[val] += i;
        }

        return ans;
    }
};