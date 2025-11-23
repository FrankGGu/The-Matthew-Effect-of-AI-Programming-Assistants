class Solution {
public:
    int findBuilding(vector<int>& heights) {
        int n = heights.size();
        if (n == 1) return 0;

        vector<int> left(n), right(n);
        left[0] = 0;
        for (int i = 1; i < n; i++) {
            left[i] = heights[i] > heights[left[i - 1]] ? i : left[i - 1];
        }

        right[n - 1] = n - 1;
        for (int i = n - 2; i >= 0; i--) {
            right[i] = heights[i] > heights[right[i + 1]] ? i : right[i + 1];
        }

        for (int i = 0; i < n; i++) {
            if (left[i] == right[i]) return i;
        }

        return -1;
    }
};