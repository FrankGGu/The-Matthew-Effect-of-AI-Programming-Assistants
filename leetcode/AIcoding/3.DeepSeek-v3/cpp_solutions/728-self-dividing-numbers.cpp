class Solution {
public:
    vector<int> selfDividingNumbers(int left, int right) {
        vector<int> result;
        for (int num = left; num <= right; ++num) {
            if (isSelfDividing(num)) {
                result.push_back(num);
            }
        }
        return result;
    }

private:
    bool isSelfDividing(int num) {
        int original = num;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0 || original % digit != 0) {
                return false;
            }
            num /= 10;
        }
        return true;
    }
};