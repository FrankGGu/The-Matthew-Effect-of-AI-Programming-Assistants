#include <vector>
#include <numeric>
using namespace std;

vector<int> leftRightSumDifferences(vector<int>& nums) {
    int n = nums.size();
    vector<int> result(n);
    long long totalSum = accumulate(nums.begin(), nums.end(), 0LL);
    long long leftSum = 0;

    for (int i = 0; i < n; ++i) {
        result[i] = abs(leftSum - (totalSum - leftSum - nums[i]));
        leftSum += nums[i];
    }

    return result;
}