#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int getNumber(vector<int>& nums, int n) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        for (int i = 1; i <= n; ++i) {
            if (count.find(i) == count.end()) {
                return i;
            }
        }
        return n + 1;
    }
};