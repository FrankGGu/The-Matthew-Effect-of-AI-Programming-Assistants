class Solution {
public:
    int maxBalls(int lowLimit, int highLimit) {
        vector<int> count(46, 0);
        int maxCount = 0;

        for (int i = lowLimit; i <= highLimit; ++i) {
            int sum = 0, num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            count[sum]++;
            maxCount = max(maxCount, count[sum]);
        }

        return maxCount;
    }
};