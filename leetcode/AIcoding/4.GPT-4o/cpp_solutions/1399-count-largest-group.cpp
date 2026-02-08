class Solution {
public:
    int countLargestGroup(int n) {
        unordered_map<int, int> groupCount;
        for (int i = 1; i <= n; ++i) {
            int sum = 0, num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            groupCount[sum]++;
        }

        int maxCount = 0, largestGroupSize = 0;
        for (const auto& [key, count] : groupCount) {
            if (count > maxCount) {
                maxCount = count;
                largestGroupSize = 1;
            } else if (count == maxCount) {
                largestGroupSize++;
            }
        }
        return largestGroupSize;
    }
};