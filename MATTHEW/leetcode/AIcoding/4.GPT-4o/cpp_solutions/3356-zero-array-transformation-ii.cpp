class Solution {
public:
    bool canTransform(vector<int>& arr) {
        int n = arr.size();
        long long totalSum = 0;
        for (int num : arr) {
            totalSum += num;
        }
        if (totalSum % n != 0) return false;
        long long target = totalSum / n;

        long long currentSum = 0;
        for (int num : arr) {
            currentSum += num - target;
            if (currentSum < 0) return false; // If current prefix sum goes negative
        }
        return true;
    }
};