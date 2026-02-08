class Solution {
public:
    int findTheDistanceValue(std::vector<int>& arr1, std::vector<int>& arr2, int d) {
        int distance_value = 0;
        for (int num1 : arr1) {
            bool condition_met_for_num1 = true;
            for (int num2 : arr2) {
                if (std::abs(num1 - num2) <= d) {
                    condition_met_for_num1 = false;
                    break;
                }
            }
            if (condition_met_for_num1) {
                distance_value++;
            }
        }
        return distance_value;
    }
};