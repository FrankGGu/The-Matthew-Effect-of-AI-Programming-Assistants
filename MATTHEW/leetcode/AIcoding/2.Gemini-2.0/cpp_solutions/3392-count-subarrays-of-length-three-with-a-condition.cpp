class Solution {
public:
    int countGoodSubarrays(vector<int>& arr, int k) {
        int n = arr.size();
        int count = 0;
        for (int i = 0; i <= n - 3; ++i) {
            if (arr[i] * arr[i+1] < k && arr[i] * arr[i+2] < k && arr[i+1] * arr[i+2] < k) {
                count++;
            }
        }
        return count;
    }
};