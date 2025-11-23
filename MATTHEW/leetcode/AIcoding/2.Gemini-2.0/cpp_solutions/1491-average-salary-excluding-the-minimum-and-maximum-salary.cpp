#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double average(vector<int>& salary) {
        int n = salary.size();
        if (n <= 2) return 0.0;

        int min_salary = salary[0];
        int max_salary = salary[0];
        double sum = 0.0;

        for (int s : salary) {
            min_salary = min(min_salary, s);
            max_salary = max(max_salary, s);
            sum += s;
        }

        return (sum - min_salary - max_salary) / (n - 2);
    }
};