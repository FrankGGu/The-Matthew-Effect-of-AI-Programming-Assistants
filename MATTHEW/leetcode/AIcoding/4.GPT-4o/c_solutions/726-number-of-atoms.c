#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char *element;
    int count;
} Atom;

int compare(const void *a, const void *b) {
    return strcmp((*(Atom **)a)->element, (*(Atom **)b)->element);
}

char *countOfAtoms(char *formula) {
    int len = strlen(formula);
    Atom **atoms = malloc(len * sizeof(Atom *));
    int top = 0;

    for (int i = 0; i < len;) {
        char *element = malloc(3);
        element[0] = formula[i];
        int j = 1;
        if (i + 1 < len && islower(formula[i + 1])) {
            element[1] = formula[i + 1];
            element[2] = '\0';
            i += 2;
        } else {
            element[1] = '\0';
            i++;
        }

        int count = 0;
        while (i < len && isdigit(formula[i])) {
            count = count * 10 + (formula[i] - '0');
            i++;
        }
        count = (count == 0) ? 1 : count;

        int found = 0;
        for (int k = 0; k < top; k++) {
            if (strcmp(atoms[k]->element, element) == 0) {
                atoms[k]->count += count;
                found = 1;
                break;
            }
        }

        if (!found) {
            atoms[top] = malloc(sizeof(Atom));
            atoms[top]->element = element;
            atoms[top]->count = count;
            top++;
        } else {
            free(element);
        }
    }

    qsort(atoms, top, sizeof(Atom *), compare);

    char *result = malloc(len * 2);
    result[0] = '\0';
    for (int k = 0; k < top; k++) {
        strcat(result, atoms[k]->element);
        char countStr[12];
        if (atoms[k]->count > 1) {
            sprintf(countStr, "%d", atoms[k]->count);
            strcat(result, countStr);
        }
        free(atoms[k]->element);
        free(atoms[k]);
    }

    free(atoms);
    return result;
}