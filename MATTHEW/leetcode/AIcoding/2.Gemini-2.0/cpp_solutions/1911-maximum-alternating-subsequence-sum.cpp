#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxAlternatingSum(vector<int>& nums) {
        long long even = 0, odd = 0;
        for (int num : nums) {
            even = max(even, odd + num);
            odd = max(odd, even - num);
        }
        return even;
    }
};