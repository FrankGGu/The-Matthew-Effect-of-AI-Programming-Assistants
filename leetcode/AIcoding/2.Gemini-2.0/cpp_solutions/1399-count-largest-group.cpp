#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int countLargestGroup(int n) {
        map<int, int> sumCount;
        int maxSum = 0;
        for (int i = 1; i <= n; ++i) {
            int sum = 0;
            int temp = i;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            sumCount[sum]++;
            maxSum = max(maxSum, sumCount[sum]);
        }

        int count = 0;
        for (auto const& [key, val] : sumCount) {
            if (val == maxSum) {
                count++;
            }
        }
        return count;
    }
};