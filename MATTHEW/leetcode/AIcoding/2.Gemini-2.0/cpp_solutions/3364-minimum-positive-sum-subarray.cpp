#include <vector>
#include <numeric>

using namespace std;

int minStartValue(vector<int>& nums) {
    int minSum = 0;
    int currentSum = 0;
    for (int num : nums) {
        currentSum += num;
        minSum = min(minSum, currentSum);
    }
    return max(1, 1 - minSum);
}