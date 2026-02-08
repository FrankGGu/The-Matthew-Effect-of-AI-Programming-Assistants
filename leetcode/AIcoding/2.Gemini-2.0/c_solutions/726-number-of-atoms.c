#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char atom[3];
    int count;
} AtomCount;

char* countOfAtoms(char* formula) {
    int len = strlen(formula);
    AtomCount* stack = (AtomCount*)malloc(sizeof(AtomCount) * (len / 2 + 1));
    int top = -1;
    int i = 0;
    while (i < len) {
        if (isupper(formula[i])) {
            char atom[3] = {0};
            atom[0] = formula[i];
            i++;
            if (i < len && islower(formula[i])) {
                atom[1] = formula[i];
                i++;
            }
            int count = 1;
            if (i < len && isdigit(formula[i])) {
                count = 0;
                while (i < len && isdigit(formula[i])) {
                    count = count * 10 + (formula[i] - '0');
                    i++;
                }
            }
            int found = 0;
            for (int j = 0; j <= top; j++) {
                if (strcmp(stack[j].atom, atom) == 0) {
                    stack[j].count += count;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                top++;
                strcpy(stack[top].atom, atom);
                stack[top].count = count;
            }
        } else if (formula[i] == '(') {
            top++;
            strcpy(stack[top].atom, "(");
            stack[top].count = 0;
            i++;
        } else if (formula[i] == ')') {
            i++;
            int count = 1;
            if (i < len && isdigit(formula[i])) {
                count = 0;
                while (i < len && isdigit(formula[i])) {
                    count = count * 10 + (formula[i] - '0');
                    i++;
                }
            }
            for (int j = top; j >= 0; j--) {
                if (strcmp(stack[j].atom, "(") == 0) {
                    top = j - 1;
                    for (int k = j + 1; k <= top + 1; k++) {
                        stack[k].count *= count;
                    }
                    break;
                }
            }
        }
    }

    int numAtoms = 0;
    for (int i = 0; i <= top; i++) {
        numAtoms++;
    }

    AtomCount* atoms = (AtomCount*)malloc(sizeof(AtomCount) * numAtoms);
    int atomIndex = 0;
    for (int i = 0; i <= top; i++) {
        int found = 0;
        for(int j = 0; j < atomIndex; j++){
            if(strcmp(atoms[j].atom, stack[i].atom) == 0){
                atoms[j].count += stack[i].count;
                found = 1;
                break;
            }
        }
        if(!found){
            strcpy(atoms[atomIndex].atom, stack[i].atom);
            atoms[atomIndex].count = stack[i].count;
            atomIndex++;
        }
    }

    for (int i = 0; i < atomIndex - 1; i++) {
        for (int j = i + 1; j < atomIndex; j++) {
            if (strcmp(atoms[i].atom, atoms[j].atom) > 0) {
                AtomCount temp = atoms[i];
                atoms[i] = atoms[j];
                atoms[j] = temp;
            }
        }
    }

    int resultLen = 1;
    for (int i = 0; i < atomIndex; i++) {
        resultLen += strlen(atoms[i].atom);
        if (atoms[i].count > 1) {
            int tempCount = atoms[i].count;
            int digits = 0;
            while (tempCount > 0) {
                tempCount /= 10;
                digits++;
            }
            resultLen += digits;
        }
    }

    char* result = (char*)malloc(sizeof(char) * (resultLen + 1));
    result[0] = '\0';
    for (int i = 0; i < atomIndex; i++) {
        strcat(result, atoms[i].atom);
        if (atoms[i].count > 1) {
            char countStr[10];
            sprintf(countStr, "%d", atoms[i].count);
            strcat(result, countStr);
        }
    }

    free(stack);
    free(atoms);
    return result;
}