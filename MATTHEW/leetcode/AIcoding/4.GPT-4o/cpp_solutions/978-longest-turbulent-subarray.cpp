class Solution {
public:
    int maxTurbulenceSize(vector<int>& arr) {
        int n = arr.size();
        if (n < 2) return n;

        int maxLength = 1;
        int currentLength = 1;
        bool prevComparison = false;

        for (int i = 1; i < n; i++) {
            if (arr[i] > arr[i - 1]) {
                if (prevComparison == false) {
                    currentLength++;
                    prevComparison = true;
                } else {
                    currentLength = 2;
                }
            } else if (arr[i] < arr[i - 1]) {
                if (prevComparison == true) {
                    currentLength++;
                    prevComparison = false;
                } else {
                    currentLength = 2;
                }
            } else {
                currentLength = 1;
                prevComparison = false;
            }
            maxLength = max(maxLength, currentLength);
        }

        return maxLength;
    }
};