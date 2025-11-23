#include <stddef.h> // Required for size_t
#include <stdbool.h> // Required for bool

int maxProfit(int* customers, int customersSize, int boardingCost, int runningCost) {
    long long currentCustomersWaiting = 0;
    long long currentProfit = 0;
    long long maxProfitValue = 0; 
    int minRotationsForMaxProfit = 0; 
    int rotations = 0;
    int customerIdx = 0;

    while (customerIdx < customersSize || currentCustomersWaiting > 0) {
        if (customerIdx < customersSize) {
            currentCustomersWaiting += customers[customerIdx];
            customerIdx++;
        }

        long long boardedCustomers;
        if (currentCustomersWaiting >= 4) {
            boardedCustomers = 4;
        } else {
            boardedCustomers = currentCustomersWaiting;
        }
        currentCustomersWaiting -= boardedCustomers;

        currentProfit += (boardedCustomers * boardingCost) - runningCost;
        rotations++;

        if (currentProfit > maxProfitValue) {
            maxProfitValue = currentProfit;
            minRotationsForMaxProfit = rotations;
        }
    }

    if (maxProfitValue <= 0) {
        return -1;
    } else {
        return minRotationsForMaxProfit;
    }
}