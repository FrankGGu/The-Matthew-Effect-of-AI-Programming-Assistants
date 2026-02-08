#include <vector>

using namespace std;

class Solution {
public:
    long long xSumOfKSubArrays(vector<int>& arr, int k, int x) {
        int n = arr.size();
        long long ans = 0;
        for (int i = 0; i <= n - k; ++i) {
            long long sum = 0;
            for (int j = i; j < i + k; ++j) {
                sum += (long long)arr[j];
            }
            ans += sum * x;
        }
        return ans;
    }
};