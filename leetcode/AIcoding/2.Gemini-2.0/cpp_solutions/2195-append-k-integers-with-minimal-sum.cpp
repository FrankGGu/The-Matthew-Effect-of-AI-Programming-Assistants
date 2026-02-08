#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimalKSum(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        long long sum = 0;
        long long count = 0;
        long long next_num = 1;

        for (int num : nums) {
            if (count >= k) break;
            if (num >= next_num) {
                long long diff = min((long long)k - count, (long long)num - next_num);
                sum += (next_num + next_num + diff - 1) * diff / 2;
                count += diff;
                next_num += diff;
            }
            next_num = max((long long)next_num, (long long)num + 1);
        }

        if (count < k) {
            long long diff = k - count;
            sum += (next_num + next_num + diff - 1) * diff / 2;
        }

        return sum;
    }
};