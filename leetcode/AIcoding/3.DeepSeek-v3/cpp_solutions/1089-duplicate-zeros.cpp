class Solution {
public:
    void duplicateZeros(vector<int>& arr) {
        int n = arr.size();
        int zeros = count(arr.begin(), arr.end(), 0);
        int j = n + zeros - 1;
        for (int i = n - 1; i >= 0; --i) {
            if (arr[i] == 0) {
                if (j < n) arr[j] = 0;
                --j;
            }
            if (j < n) arr[j] = arr[i];
            --j;
        }
    }
};