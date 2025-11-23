class Solution {
public:
    int countLargestGroup(int n) {
        unordered_map<int, int> sumCount;
        int maxSize = 0;

        for (int i = 1; i <= n; ++i) {
            int num = i;
            int sum = 0;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            sumCount[sum]++;
            maxSize = max(maxSize, sumCount[sum]);
        }

        int count = 0;
        for (const auto& pair : sumCount) {
            if (pair.second == maxSize) {
                count++;
            }
        }

        return count;
    }
};