class Solution {
public:
    int findKthPositive(vector<int>& arr, int k) {
        int n = arr.size();
        int missingCount = 0;
        int current = 1;
        int index = 0;

        while (missingCount < k) {
            if (index < n && arr[index] == current) {
                index++;
            } else {
                missingCount++;
            }
            if (missingCount < k) {
                current++;
            }
        }
        return current;
    }
};