class Solution {
public:
    int trainingPlanV(int n, vector<int>& calories) {
        int totalCalories = accumulate(calories.begin(), calories.end(), 0);
        int maxCalories = *max_element(calories.begin(), calories.end());
        int left = maxCalories, right = totalCalories, answer = totalCalories;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int days = 1, currentCalories = 0;

            for (int cal : calories) {
                if (currentCalories + cal > mid) {
                    days++;
                    currentCalories = cal;
                } else {
                    currentCalories += cal;
                }
            }

            if (days <= n) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return answer;
    }
};