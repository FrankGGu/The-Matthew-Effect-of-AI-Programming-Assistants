class Solution {
public:
    int maxFruits(vector<vector<int>>& fruits) {
        int n = fruits.size();
        if (n == 0) return 0;

        int maxFruits = 0;
        int left = 0, right = 0;
        int currentFruits = 0;

        while (right < n) {
            currentFruits += fruits[right][1];

            while (fruits[right][0] - fruits[left][0] > 2) {
                currentFruits -= fruits[left][1];
                left++;
            }

            maxFruits = max(maxFruits, currentFruits);
            right++;
        }

        return maxFruits;
    }
};