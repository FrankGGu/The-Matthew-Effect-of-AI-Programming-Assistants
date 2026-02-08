#include <vector>
#include <algorithm>

using namespace std;

vector<int> minSubsequence(vector<int>& nums) {
    sort(nums.begin(), nums.end(), greater<int>());
    vector<int> result;
    int totalSum = accumulate(nums.begin(), nums.end(), 0);
    int subsequenceSum = 0;

    for (int num : nums) {
        result.push_back(num);
        subsequenceSum += num;
        totalSum -= num;
        if (subsequenceSum > totalSum) {
            break;
        }
    }

    return result;
}