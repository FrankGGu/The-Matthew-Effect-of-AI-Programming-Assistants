#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> baseNeg2(int n) {
        if (n == 0) {
            return {0};
        }
        vector<int> res;
        while (n != 0) {
            int rem = n % -2;
            n /= -2;
            if (rem < 0) {
                rem += 2;
                n += 1;
            }
            res.insert(res.begin(), rem);
        }
        return res;
    }
};