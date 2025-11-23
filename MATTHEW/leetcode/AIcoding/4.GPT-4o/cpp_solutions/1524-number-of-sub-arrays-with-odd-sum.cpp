class Solution {
public:
    int numOfSubarrays(vector<int>& arr) {
        int oddCount = 0, evenCount = 1, oddSum = 0, result = 0;
        for (int num : arr) {
            oddSum += num;
            if (oddSum % 2) {
                result += evenCount;
                oddCount++;
            } else {
                result += oddCount;
                evenCount++;
            }
        }
        return result;
    }
};