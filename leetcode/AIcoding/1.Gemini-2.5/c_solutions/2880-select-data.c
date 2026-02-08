#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void selectData() {
    printf("SELECT * FROM your_table_name;\n");
}

int main() {
    selectData(); // Calls the function that prints the SQL query.
    return 0;
}