class Solution {
public:
    int getWinner(vector<int>& arr, int k) {
        int maxNum = arr[0], count = 0;
        for (int num : arr) {
            if (num > maxNum) {
                maxNum = num;
                count = 1;
            } else {
                count++;
            }
            if (count == k) break;
        }
        return maxNum;
    }
};