class Solution {
public:
    int paintingPlan(int n, int m, int k) {
        int count = 0;
        for (int R = 1; R <= n; ++R) {
            if (k % R == 0) {
                int C = k / R;
                if (C <= m) {
                    count++;
                }
            }
        }
        return count;
    }
};