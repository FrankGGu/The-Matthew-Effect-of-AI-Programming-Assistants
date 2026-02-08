class Solution {
public:
    int minimumBoxes(int n) {
        int k = 1;
        while (k * (k + 1) * (k + 2) / 6 < n) {
            k++;
        }
        if (k * (k + 1) * (k + 2) / 6 == n) {
            return k * (k + 1) / 2;
        }
        k--;
        int remaining = n - k * (k + 1) * (k + 2) / 6;
        int m = 1;
        while (m * (m + 1) / 2 < remaining) {
            m++;
        }
        return k * (k + 1) / 2 + m;
    }
};