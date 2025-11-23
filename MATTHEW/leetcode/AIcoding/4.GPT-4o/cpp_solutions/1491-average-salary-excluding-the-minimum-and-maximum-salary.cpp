class Solution {
public:
    double average(std::vector<int>& salary) {
        int minSalary = INT_MAX, maxSalary = INT_MIN;
        double total = 0.0;
        for (int s : salary) {
            total += s;
            minSalary = std::min(minSalary, s);
            maxSalary = std::max(maxSalary, s);
        }
        total -= (minSalary + maxSalary);
        return total / (salary.size() - 2);
    }
};