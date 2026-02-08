#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double average(vector<int>& salary) {
        int n = salary.size();
        if (n <= 2) return 0.0;

        int minSalary = salary[0];
        int maxSalary = salary[0];
        double sum = 0;

        for (int s : salary) {
            minSalary = min(minSalary, s);
            maxSalary = max(maxSalary, s);
            sum += s;
        }

        sum -= (minSalary + maxSalary);
        return sum / (n - 2);
    }
};