#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfHiddenSequences(const vector<int>& roll) {
        int n = roll.size();
        vector<int> count(7, 0);
        for (int i = 0; i < n; ++i) {
            count[roll[i]]++;
        }
        int res = 1;
        for (int i = 1; i <= 6; ++i) {
            if (count[i] == 0) {
                return 0;
            }
            res *= count[i];
        }
        return res;
    }
};