#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* from;
    char* to;
    double conversion;
} Conversion;

double convert(char* from, char* to, Conversion* conversions, int conversionsSize) {
    for (int i = 0; i < conversionsSize; i++) {
        if (strcmp(conversions[i].from, from) == 0 && strcmp(conversions[i].to, to) == 0) {
            return conversions[i].conversion;
        }
    }
    return -1.0;
}