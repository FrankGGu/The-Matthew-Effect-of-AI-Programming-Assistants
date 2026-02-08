class Solution {
public:
    int countBalls(int lowLimit, int highLimit) {
        unordered_map<int, int> boxCount;
        int maxCount = 0;
        for (int i = lowLimit; i <= highLimit; ++i) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            boxCount[sum]++;
            if (boxCount[sum] > maxCount) {
                maxCount = boxCount[sum];
            }
        }
        return maxCount;
    }
};