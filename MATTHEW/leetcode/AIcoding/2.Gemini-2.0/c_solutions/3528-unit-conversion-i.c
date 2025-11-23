#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double convertTemperature(double celsius, int toFahrenheit) {
    if (toFahrenheit) {
        return celsius * 1.80 + 32.00;
    } else {
        return celsius + 273.15;
    }
}