#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getNoZeroIntegers(int n) {
        for (int i = 1; i < n; ++i) {
            int j = n - i;
            if (checkNoZero(i) && checkNoZero(j)) {
                return {i, j};
            }
        }
        return {};
    }

private:
    bool checkNoZero(int num) {
        while (num > 0) {
            if (num % 10 == 0) {
                return false;
            }
            num /= 10;
        }
        return true;
    }
};