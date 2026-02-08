class Solution {
public:
    int closestPerson(vector<int>& arr, int k) {
        int n = arr.size();
        int minDiff = INT_MAX;
        int closestIndex = -1;

        for (int i = 0; i < n; ++i) {
            if (arr[i] >= arr[k]) {
                int diff = arr[i] - arr[k];
                if (diff < minDiff) {
                    minDiff = diff;
                    closestIndex = i;
                }
            }
        }
        return closestIndex;
    }
};