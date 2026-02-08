#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& target, int arrLen) {
        int n = target.size();
        vector<int> count(1001, 0);
        for (int i = 0; i < n; ++i) {
            count[target[i]]++;
        }
        int operations = 0;
        for (int i = 0; i < arrLen; ++i) {
            if (count[target[i]] > 0) {
                count[target[i]]--;
            } else {
                operations++;
            }
        }
        return operations;
    }
};