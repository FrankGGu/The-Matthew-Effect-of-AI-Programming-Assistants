#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

long double convertToLongDouble(char* s) {
    long double result = 0.0L;
    int i = 0;

    // Parse integer part
    while (s[i] != '\0' && s[i] != '.') {
        result = result * 10.0L + (s[i] - '0');
        i++;
    }

    if (s[i] == '\0') { // Integer only, e.g., "123"
        return result;
    }

    i++; // Skip '.'

    // Store the start index of the non-repeating part
    int nonRepeatingStart = i;

    // Parse non-repeating fractional part
    long double powerOf10ForNonRepeating = 0.1L;
    while (s[i] != '\0' && s[i] != '(') {
        result += (s[i] - '0') * powerOf10ForNonRepeating;
        powerOf10ForNonRepeating *= 0.1L;
        i++;
    }

    if (s[i] == '\0') { // Non-repeating fractional part only, e.g., "123.456"
        return result;
    }

    i++; // Skip '('

    // Parse repeating fractional part
    char repeatingDigits[10]; // Max 9 digits + null terminator
    int k = 0;
    while (s[i] != ')') {
        repeatingDigits[k++] = s[i];
        i++;
    }
    repeatingDigits[k] = '\0';
    int repeatingLen = k;

    if (repeatingLen == 0) { // Empty repeating part, e.g., "1.2()"
        return result;
    }

    // Calculate the numerator for the repeating part
    long double repeatingValNumerator = 0.0L;
    for(int digitIdx = 0; digitIdx < repeatingLen; digitIdx++) {
        repeatingValNumerator = repeatingValNumerator * 10.0L + (repeatingDigits[digitIdx] - '0');
    }

    // Calculate the denominator for the repeating part: (10^len(R) - 1)
    long double repeatingDivisorBase = 1.0L;
    for (int count = 0; count < repeatingLen; count++) {
        repeatingDivisorBase *= 10.0L;
    }
    repeatingDivisorBase -= 1.0L;

    // Calculate 10^len(F) for the non-repeating part
    long double nonRepeatingPowerOf10 = 1.0L;
    int nonRepeatingActualLen = i - 1 - nonRepeatingStart; // i is at ')', -1 for '(', -1 for length
    for (int count = 0; count < nonRepeatingActualLen; count++) {
        nonRepeatingPowerOf10 *= 10.0L;
    }

    // Add the repeating part to the result using the formula: R / (10^len(F) * (10^len(R) - 1))
    result += repeatingValNumerator / (nonRepeatingPowerOf10 * repeatingDivisorBase);

    return result;
}

_Bool isRationalEqual(char* s, char* t) {
    long double val_s = convertToLongDouble(s);
    long double val_t = convertToLongDouble(t);

    long double epsilon = 1e-18L; 

    return fabsl(val_s - val_t) < epsilon;
}