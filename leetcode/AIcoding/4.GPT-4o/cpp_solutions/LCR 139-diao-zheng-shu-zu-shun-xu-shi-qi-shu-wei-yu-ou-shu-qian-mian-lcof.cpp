class Solution {
public:
    bool canComplete(int n, vector<int>& calories) {
        int totalCalories = accumulate(calories.begin(), calories.end(), 0);
        return totalCalories >= n * 2000;
    }
};