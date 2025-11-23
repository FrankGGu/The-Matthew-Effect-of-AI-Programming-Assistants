#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double trimMean(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        int n = arr.size();
        int trim_size = n * 0.05;
        double sum = 0;
        for (int i = trim_size; i < n - trim_size; ++i) {
            sum += arr[i];
        }
        return sum / (n - 2 * trim_size);
    }
};