#include <string.h>

double convert(double value, char* fromUnit, char* toUnit) {
    double valueInMeters;

    if (strcmp(fromUnit, "m") == 0) {
        valueInMeters = value;
    } else if (strcmp(fromUnit, "cm") == 0) {
        valueInMeters = value * 0.01;
    } else if (strcmp(fromUnit, "km") == 0) {
        valueInMeters = value * 1000.0;
    } else {
        return 0.0; 
    }

    if (strcmp(toUnit, "m") == 0) {
        return valueInMeters;
    } else if (strcmp(toUnit, "cm") == 0) {
        return valueInMeters * 100.0;
    } else if (strcmp(toUnit, "km") == 0) {
        return valueInMeters / 1000.0;
    } else {
        return 0.0;
    }
}