class Solution {
public:
    double trimMean(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        int n = arr.size();
        int toRemove = n * 0.05;
        double sum = 0;
        for (int i = toRemove; i < n - toRemove; ++i) {
            sum += arr[i];
        }
        return sum / (n - 2 * toRemove);
    }
};