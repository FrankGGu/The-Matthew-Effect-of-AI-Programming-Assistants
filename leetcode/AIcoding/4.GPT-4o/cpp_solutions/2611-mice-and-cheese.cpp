class Solution {
public:
    int miceAndCheese(vector<int>& mice, vector<int>& cheese, int k) {
        int n = mice.size();
        vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = mice[i] - cheese[i];
        }
        sort(diff.begin(), diff.end());
        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (i < n - k) {
                result += cheese[i];
            } else {
                result += mice[i];
            }
        }
        return result;
    }
};