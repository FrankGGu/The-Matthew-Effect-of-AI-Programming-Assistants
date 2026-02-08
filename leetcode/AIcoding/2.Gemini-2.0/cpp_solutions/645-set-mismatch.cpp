#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> findErrorNums(vector<int>& nums) {
        int n = nums.size();
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        long long expectedSum = (long long)n * (n + 1) / 2;

        long long diff = sum - expectedSum;

        vector<int> count(n + 1, 0);
        int duplicate = -1;
        for (int num : nums) {
            count[num]++;
            if (count[num] > 1) {
                duplicate = num;
            }
        }

        int missing = duplicate - (diff);

        return {duplicate, missing};
    }
};