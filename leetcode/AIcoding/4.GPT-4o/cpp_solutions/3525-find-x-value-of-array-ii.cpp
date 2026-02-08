class Solution {
public:
    int findX(int n, vector<int>& arr) {
        int totalX = 0;
        for (int i = 0; i < n; ++i) {
            totalX ^= arr[i];
        }
        return totalX;
    }
};