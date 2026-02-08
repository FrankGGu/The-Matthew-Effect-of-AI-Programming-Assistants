#include <stdio.h>
#include <stdlib.h>

double average(int* salary, int salarySize) {
    int min = salary[0];
    int max = salary[0];
    int sum = 0;

    for (int i = 0; i < salarySize; i++) {
        sum += salary[i];
        if (salary[i] < min) {
            min = salary[i];
        }
        if (salary[i] > max) {
            max = salary[i];
        }
    }

    sum -= min + max;
    return (double)sum / (salarySize - 2);
}