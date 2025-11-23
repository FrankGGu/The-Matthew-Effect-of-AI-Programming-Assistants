#include <limits.h>

double average(int* salary, int salarySize) {
    if (salarySize <= 2) {
        return 0.0; // Should not happen based on constraints (n >= 3)
    }

    long long totalSum = 0;
    int minSalary = INT_MAX;
    int maxSalary = INT_MIN;

    for (int i = 0; i < salarySize; i++) {
        totalSum += salary[i];
        if (salary[i] < minSalary) {
            minSalary = salary[i];
        }
        if (salary[i] > maxSalary) {
            maxSalary = salary[i];
        }
    }

    totalSum -= minSalary;
    totalSum -= maxSalary;

    return (double)totalSum / (salarySize - 2);
}