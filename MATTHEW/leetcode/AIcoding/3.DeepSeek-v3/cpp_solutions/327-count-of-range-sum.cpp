#include <vector>
#include <set>
using namespace std;

class Solution {
public:
    int countRangeSum(vector<int>& nums, int lower, int upper) {
        multiset<long long> prefixSums;
        prefixSums.insert(0);
        long long sum = 0;
        int res = 0;
        for (int num : nums) {
            sum += num;
            res += distance(prefixSums.lower_bound(sum - upper), prefixSums.upper_bound(sum - lower));
            prefixSums.insert(sum);
        }
        return res;
    }
};