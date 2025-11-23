#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int max( int* customers, int* grumpy, int customersSize, int grumpySize, int X) {
    int max_customers = 0;
    int current_customers = 0;
    for (int i = 0; i < X; i++) {
        current_customers += customers[i];
    }
    max_customers = current_customers;
    for (int i = X; i < customersSize; i++) {
        current_customers += customers[i] - customers[i - X];
        max_customers = max(max_customers, current_customers);
    }
    for (int i = 0; i < customersSize; i++) {
        if (grumpy[i] == 1) {
            max_customers += customers[i];
        }
    }
    return max_customers;
}