using namespace std;

class Solution {
public:
    long long sumVariableLengthSubarrays(vector<int>& arr) {
        long long total = 0;
        int n = arr.size();
        for (int i = 0; i < n; ++i) {
            total += static_cast<long long>(arr[i]) * (i + 1) * (n - i);
        }
        return total;
    }
};