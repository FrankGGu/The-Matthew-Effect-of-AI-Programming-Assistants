#include <unordered_set>

class Solution {
public:
    int countDistinctIntegers(vector<int>& nums) {
        std::unordered_set<int> distinct_integers;
        for (int num : nums) {
            distinct_integers.insert(num);
            int reversed_num = 0;
            int temp = num;
            while (temp > 0) {
                reversed_num = reversed_num * 10 + temp % 10;
                temp /= 10;
            }
            distinct_integers.insert(reversed_num);
        }
        return distinct_integers.size();
    }
};