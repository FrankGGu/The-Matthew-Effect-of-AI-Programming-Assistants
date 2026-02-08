double average(int* salary, int salarySize) {
    int min = salary[0], max = salary[0];
    double total = 0;

    for (int i = 0; i < salarySize; i++) {
        if (salary[i] < min) min = salary[i];
        if (salary[i] > max) max = salary[i];
        total += salary[i];
    }

    total -= (min + max);
    return total / (salarySize - 2);
}