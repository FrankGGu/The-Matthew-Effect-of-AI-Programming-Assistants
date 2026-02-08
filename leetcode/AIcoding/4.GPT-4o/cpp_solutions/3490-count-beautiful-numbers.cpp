class Solution {
public:
    int countBeautifulNumbers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; ++i) {
            if (isBeautiful(i)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isBeautiful(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum % 3 == 0 && sum % 5 == 0;
    }
};