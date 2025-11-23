#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Product {
    int product_id;
    char product_name[50];
    int price;
};

struct Serial {
    int serial_number;
    int product_id;
};