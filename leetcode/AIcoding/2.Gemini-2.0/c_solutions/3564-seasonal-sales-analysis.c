#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MONTHS 12
#define MAX_PRODUCTS 100

typedef struct {
    char product_id[10];
    int monthly_sales[MAX_MONTHS];
} ProductSales;