#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double average(int* salary, int salarySize){
    int min = salary[0];
    int max = salary[0];
    double sum = 0;

    for (int i = 0; i < salarySize; i++) {
        if (salary[i] < min) {
            min = salary[i];
        }
        if (salary[i] > max) {
            max = salary[i];
        }
        sum += salary[i];
    }

    sum -= (min + max);
    return sum / (salarySize - 2);
}