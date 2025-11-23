#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> selfDividingNumbers(int left, int right) {
        vector<int> result;
        for (int i = left; i <= right; ++i) {
            if (isSelfDividing(i)) {
                result.push_back(i);
            }
        }
        return result;
    }

private:
    bool isSelfDividing(int n) {
        int original = n;
        while (n > 0) {
            int digit = n % 10;
            if (digit == 0 || original % digit != 0) {
                return false;
            }
            n /= 10;
        }
        return true;
    }
};