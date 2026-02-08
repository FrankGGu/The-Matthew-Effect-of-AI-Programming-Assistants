class Solution {
public:
    int maxSequenceValue(vector<int>& arr) {
        int maxValue = 0;
        int currentSum = 0;
        for (int num : arr) {
            currentSum += num;
            if (currentSum < 0) currentSum = 0;
            maxValue = max(maxValue, currentSum);
        }
        return maxValue;
    }
};