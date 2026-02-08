class Solution {
public:
    vector<int> highAccessEmployees(vector<vector<int>>& employees, int threshold) {
        vector<int> result;
        for (const auto& emp : employees) {
            if (emp[1] > threshold) {
                result.push_back(emp[0]);
            }
        }
        return result;
    }
};