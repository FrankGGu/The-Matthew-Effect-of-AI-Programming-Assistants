#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minOperations(vector<int>& nums, int k) {
        vector<int> positive;
        long long sum = 0;
        for (int num : nums) {
            if (num > 0) {
                positive.push_back(num);
                sum += num;
            }
        }

        if (sum >= k) {
            return 0;
        }

        sort(positive.rbegin(), positive.rend());

        long long operations = 0;
        for (int num : positive) {
            sum -= num;
            sum += (num / 2);
            operations++;
            if (sum >= k) {
                return operations;
            }
        }

        return -1;
    }
};