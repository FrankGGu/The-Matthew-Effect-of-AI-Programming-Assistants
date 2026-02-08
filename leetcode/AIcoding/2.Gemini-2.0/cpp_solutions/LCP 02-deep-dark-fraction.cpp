#include <numeric>

class Solution {
public:
    vector<int> fraction(vector<int>& cont) {
        int n = cont.size();
        if (n == 1) {
            return {cont[0], 1};
        }
        int a = cont[n - 1], b = 1;
        for (int i = n - 2; i >= 0; --i) {
            int tmp = a;
            a = cont[i] * a + b;
            b = tmp;
        }
        return {a, b};
    }
};