#include <vector>

using namespace std;

class Solution {
public:
    long long findTheSumOfAverages(vector<int>& nums, int k) {
        int n = nums.size();
        long long sum = 0;
        for (int i = 0; i <= n - k; ++i) {
            double avg = 0;
            for (int j = i; j < i + k; ++j) {
                avg += nums[j];
            }
            avg /= k;
            sum += avg;
        }
        return sum;
    }
};