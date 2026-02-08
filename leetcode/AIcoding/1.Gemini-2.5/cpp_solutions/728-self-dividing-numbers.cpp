#include <vector>

class Solution {
public:
    std::vector<int> selfDividingNumbers(int left, int right) {
        std::vector<int> result;
        for (int i = left; i <= right; ++i) {
            if (isSelfDividing(i)) {
                result.push_back(i);
            }
        }
        return result;
    }

private:
    bool isSelfDividing(int num) {
        int temp = num;
        while (temp > 0) {
            int digit = temp % 10;
            if (digit == 0 || num % digit != 0) {
                return false;
            }
            temp /= 10;
        }
        return true;
    }
};