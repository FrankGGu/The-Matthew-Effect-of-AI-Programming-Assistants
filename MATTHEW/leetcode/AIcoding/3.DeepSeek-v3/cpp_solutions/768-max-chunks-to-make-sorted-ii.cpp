class Solution {
public:
    int maxChunksToSorted(vector<int>& arr) {
        vector<int> sortedArr = arr;
        sort(sortedArr.begin(), sortedArr.end());
        long sum1 = 0, sum2 = 0;
        int res = 0;
        for (int i = 0; i < arr.size(); ++i) {
            sum1 += arr[i];
            sum2 += sortedArr[i];
            if (sum1 == sum2) {
                ++res;
            }
        }
        return res;
    }
};