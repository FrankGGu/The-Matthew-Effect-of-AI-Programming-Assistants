double convert(double x, char* fromUnit, char* toUnit) {
    double conversionFactor = 1.0;

    if (strcmp(fromUnit, "m") == 0) {
        if (strcmp(toUnit, "km") == 0) conversionFactor = 0.001;
        else if (strcmp(toUnit, "cm") == 0) conversionFactor = 100;
        else if (strcmp(toUnit, "mm") == 0) conversionFactor = 1000;
        else if (strcmp(toUnit, "ft") == 0) conversionFactor = 3.28084;
        else if (strcmp(toUnit, "in") == 0) conversionFactor = 39.3701;
    } else if (strcmp(fromUnit, "km") == 0) {
        if (strcmp(toUnit, "m") == 0) conversionFactor = 1000;
        else if (strcmp(toUnit, "cm") == 0) conversionFactor = 100000;
        else if (strcmp(toUnit, "mm") == 0) conversionFactor = 1000000;
        else if (strcmp(toUnit, "ft") == 0) conversionFactor = 3280.84;
        else if (strcmp(toUnit, "in") == 0) conversionFactor = 39370.1;
    } else if (strcmp(fromUnit, "cm") == 0) {
        if (strcmp(toUnit, "m") == 0) conversionFactor = 0.01;
        else if (strcmp(toUnit, "km") == 0) conversionFactor = 0.00001;
        else if (strcmp(toUnit, "mm") == 0) conversionFactor = 10;
        else if (strcmp(toUnit, "ft") == 0) conversionFactor = 0.0328084;
        else if (strcmp(toUnit, "in") == 0) conversionFactor = 0.393701;
    } else if (strcmp(fromUnit, "mm") == 0) {
        if (strcmp(toUnit, "m") == 0) conversionFactor = 0.001;
        else if (strcmp(toUnit, "km") == 0) conversionFactor = 0.000001;
        else if (strcmp(toUnit, "cm") == 0) conversionFactor = 0.1;
        else if (strcmp(toUnit, "ft") == 0) conversionFactor = 0.00328084;
        else if (strcmp(toUnit, "in") == 0) conversionFactor = 0.0393701;
    } else if (strcmp(fromUnit, "ft") == 0) {
        if (strcmp(toUnit, "m") == 0) conversionFactor = 0.3048;
        else if (strcmp(toUnit, "km") == 0) conversionFactor = 0.0003048;
        else if (strcmp(toUnit, "cm") == 0) conversionFactor = 30.48;
        else if (strcmp(toUnit, "mm") == 0) conversionFactor = 304.8;
        else if (strcmp(toUnit, "in") == 0) conversionFactor = 12;
    } else if (strcmp(fromUnit, "in") == 0) {
        if (strcmp(toUnit, "m") == 0) conversionFactor = 0.0254;
        else if (strcmp(toUnit, "km") == 0) conversionFactor = 0.0000254;
        else if (strcmp(toUnit, "cm") == 0) conversionFactor = 2.54;
        else if (strcmp(toUnit, "mm") == 0) conversionFactor = 25.4;
        else if (strcmp(toUnit, "ft") == 0) conversionFactor = 0.0833333;
    }

    return x * conversionFactor;
}