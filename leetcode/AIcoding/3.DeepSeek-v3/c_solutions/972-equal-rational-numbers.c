#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

double parseRational(char* s) {
    int len = strlen(s);
    double integer = 0.0;
    double nonRepeating = 0.0;
    double repeating = 0.0;

    int i = 0;
    // Parse integer part
    while (i < len && s[i] != '.') {
        integer = integer * 10 + (s[i] - '0');
        i++;
    }

    // Check if there's a decimal part
    if (i < len && s[i] == '.') {
        i++;

        // Parse non-repeating decimal part
        double factor = 0.1;
        while (i < len && s[i] != '(') {
            nonRepeating += (s[i] - '0') * factor;
            factor *= 0.1;
            i++;
        }

        // Parse repeating decimal part
        if (i < len && s[i] == '(') {
            i++;
            int repeatingStart = i;
            int repeatingLen = 0;

            while (i < len && s[i] != ')') {
                repeatingLen++;
                i++;
            }

            if (repeatingLen > 0) {
                double repeatingValue = 0.0;
                for (int j = repeatingStart; j < repeatingStart + repeatingLen; j++) {
                    repeatingValue = repeatingValue * 10 + (s[j] - '0');
                }

                repeating = repeatingValue / (pow(10, repeatingLen) - 1);
                repeating *= factor; // Adjust for decimal position
            }
        }
    }

    return integer + nonRepeating + repeating;
}

bool isRationalEqual(char* s, char* t) {
    double num1 = parseRational(s);
    double num2 = parseRational(t);

    // Use epsilon comparison for floating point numbers
    return fabs(num1 - num2) < 1e-12;
}