#include <stdlib.h>

int* analyzeSeasonalSales(int* months, int* sales, int salesSize, int* returnSize) {
    int* seasonalSales = (int*) malloc(sizeof(int) * 4);
    if (seasonalSales == NULL) {
        *returnSize = 0;
        return NULL;
    }

    seasonalSales[0] = 0; // Quarter 1: Jan, Feb, Mar
    seasonalSales[1] = 0; // Quarter 2: Apr, May, Jun
    seasonalSales[2] = 0; // Quarter 3: Jul, Aug, Sep
    seasonalSales[3] = 0; // Quarter 4: Oct, Nov, Dec

    for (int i = 0; i < salesSize; i++) {
        int month = months[i];
        int saleAmount = sales[i];

        if (month >= 1 && month <= 3) {
            seasonalSales[0] += saleAmount;
        } else if (month >= 4 && month <= 6) {
            seasonalSales[1] += saleAmount;
        } else if (month >= 7 && month <= 9) {
            seasonalSales[2] += saleAmount;
        } else if (month >= 10 && month <= 12) {
            seasonalSales[3] += saleAmount;
        }
    }

    *returnSize = 4;
    return seasonalSales;
}