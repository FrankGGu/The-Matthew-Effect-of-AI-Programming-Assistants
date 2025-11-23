class Solution {
public:
    double average(vector<int>& salary) {
        int min_salary = INT_MAX;
        int max_salary = INT_MIN;
        int sum = 0;
        for (int s : salary) {
            min_salary = min(min_salary, s);
            max_salary = max(max_salary, s);
            sum += s;
        }
        sum -= min_salary + max_salary;
        return (double)sum / (salary.size() - 2);
    }
};