class Solution {
public:
    vector<long long> maximumEvenSplit(long long finalSum) {
        vector<long long> result;
        if (finalSum % 2 != 0) {
            return result;
        }
        long long current = 2;
        while (finalSum >= current) {
            result.push_back(current);
            finalSum -= current;
            current += 2;
        }
        if (finalSum > 0) {
            result.back() += finalSum;
        }
        return result;
    }
};