#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    double average(std::vector<int>& salary) {
        std::sort(salary.begin(), salary.end());
        double sum = 0;
        for (int i = 1; i < salary.size() - 1; ++i) {
            sum += salary[i];
        }
        return sum / (salary.size() - 2);
    }
};