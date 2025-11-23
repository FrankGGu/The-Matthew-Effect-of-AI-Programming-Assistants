class Solution {
public:
    int findSpecialInteger(vector<int>& arr) {
        int n = arr.size();
        for (int i = 0; i < n; i++) {
            if (i + n / 4 < n && arr[i] == arr[i + n / 4]) {
                return arr[i];
            }
        }
        return -1;
    }
};