class Solution {
public:
    double trimMean(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        int n = arr.size();
        int remove = n / 20;
        double sum = 0;
        for (int i = remove; i < n - remove; ++i) {
            sum += arr[i];
        }
        return sum / (n - 2 * remove);
    }
};