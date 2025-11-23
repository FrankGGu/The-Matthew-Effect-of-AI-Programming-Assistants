#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *num;
    char *den;
} Rational;

Rational* parseRational(char *s) {
    Rational *r = (Rational*)malloc(sizeof(Rational));
    r->num = NULL;
    r->den = NULL;

    int len = strlen(s);
    char *dot = strchr(s, '.');
    if (dot == NULL) {
        r->num = strdup(s);
        r->den = "1";
        return r;
    }

    int before = dot - s;
    int after = len - (dot - s) - 1;

    char *beforeStr = (char*)malloc(before + 1);
    strncpy(beforeStr, s, before);
    beforeStr[before] = '\0';

    char *afterStr = (char*)malloc(after + 1);
    strncpy(afterStr, dot + 1, after);
    afterStr[after] = '\0';

    char *repeating = strchr(afterStr, '(');
    if (repeating != NULL) {
        *repeating = '\0';
        int nonRepeatingLen = strlen(afterStr);
        int repeatingLen = strlen(repeating + 1);

        char *nonRepeating = afterStr;
        char *repeatingPart = repeating + 1;

        int totalDigits = nonRepeatingLen + repeatingLen;
        int nonRepeatingDigits = nonRepeatingLen;

        char *numerator = (char*)malloc(256);
        sprintf(numerator, "%s%s", beforeStr, nonRepeating);
        for (int i = 0; i < repeatingLen; i++) {
            strcat(numerator, repeatingPart);
        }

        char *denominator = (char*)malloc(256);
        sprintf(denominator, "9");
        for (int i = 0; i < nonRepeatingDigits; i++) {
            strcat(denominator, "0");
        }
        for (int i = 0; i < repeatingLen; i++) {
            strcat(denominator, "9");
        }

        r->num = numerator;
        r->den = denominator;
    } else {
        char *numerator = (char*)malloc(256);
        sprintf(numerator, "%s%s", beforeStr, afterStr);

        char *denominator = (char*)malloc(256);
        sprintf(denominator, "1");
        for (int i = 0; i < after; i++) {
            strcat(denominator, "0");
        }

        r->num = numerator;
        r->den = denominator;
    }

    free(beforeStr);
    free(afterStr);
    return r;
}

void reduceRational(char **num, char **den) {
    int numInt = atoi(*num);
    int denInt = atoi(*den);

    int gcd = 1;
    int a = numInt, b = denInt;
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    gcd = a;

    char *newNum = (char*)malloc(256);
    char *newDen = (char*)malloc(256);
    sprintf(newNum, "%d", numInt / gcd);
    sprintf(newDen, "%d", denInt / gcd);

    free(*num);
    free(*den);
    *num = newNum;
    *den = newDen;
}

int isRationalEqual(char *s, char *t) {
    Rational *r1 = parseRational(s);
    Rational *r2 = parseRational(t);

    reduceRational(&r1->num, &r1->den);
    reduceRational(&r2->num, &r2->den);

    int equal = (strcmp(r1->num, r2->num) == 0 && strcmp(r1->den, r2->den) == 0);

    free(r1->num);
    free(r1->den);
    free(r1);
    free(r2->num);
    free(r2->den);
    free(r2);

    return equal;
}