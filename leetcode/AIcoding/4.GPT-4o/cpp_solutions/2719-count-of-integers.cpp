class Solution {
public:
    int countIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; ++i) {
            if (isValid(i)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isValid(int num) {
        int seen[10] = {0};
        while (num > 0) {
            int digit = num % 10;
            if (seen[digit]) return false;
            seen[digit] = 1;
            num /= 10;
        }
        return true;
    }
};