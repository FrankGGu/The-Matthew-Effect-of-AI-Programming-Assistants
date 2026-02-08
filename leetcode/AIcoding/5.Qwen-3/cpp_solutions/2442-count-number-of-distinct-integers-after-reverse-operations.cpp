#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countDistinctIntegersInReverse(vector<int>& nums) {
        unordered_set<int> s;
        for (int num : nums) {
            s.insert(num);
            int reversed = 0;
            int n = num;
            while (n > 0) {
                reversed = reversed * 10 + n % 10;
                n /= 10;
            }
            s.insert(reversed);
        }
        return s.size();
    }
};