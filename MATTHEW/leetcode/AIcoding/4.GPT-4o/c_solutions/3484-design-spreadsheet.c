#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    char value[100];
} Cell;

typedef struct {
    Cell **cells;
    int maxRow;
    int maxCol;
} Spreadsheet;

Spreadsheet* spreadsheetCreate(int height, char** width, int widthSize) {
    Spreadsheet* sp = (Spreadsheet*)malloc(sizeof(Spreadsheet));
    sp->maxRow = height;
    sp->maxCol = widthSize;
    sp->cells = (Cell**)calloc(height, sizeof(Cell*));
    for (int i = 0; i < height; i++) {
        sp->cells[i] = (Cell*)calloc(widthSize, sizeof(Cell));
        for (int j = 0; j < widthSize; j++) {
            sp->cells[i][j].row = i;
            sp->cells[i][j].col = j;
            strcpy(sp->cells[i][j].value, "");
        }
    }
    return sp;
}

void spreadsheetSet(Spreadsheet* sp, int row, int col, char* value) {
    if (row < sp->maxRow && col < sp->maxCol) {
        strcpy(sp->cells[row][col].value, value);
    }
}

char* spreadsheetGet(Spreadsheet* sp, int row, int col) {
    if (row < sp->maxRow && col < sp->maxCol) {
        return sp->cells[row][col].value;
    }
    return "";
}

char** spreadsheetGetCol(Spreadsheet* sp, int col, int* returnSize) {
    char** result = (char**)malloc(sp->maxRow * sizeof(char*));
    *returnSize = 0;
    for (int i = 0; i < sp->maxRow; i++) {
        result[i] = (char*)malloc(100 * sizeof(char));
        strcpy(result[i], sp->cells[i][col].value);
        if (strlen(result[i]) > 0) {
            (*returnSize)++;
        }
    }
    return result;
}

void spreadsheetFree(Spreadsheet* sp) {
    for (int i = 0; i < sp->maxRow; i++) {
        free(sp->cells[i]);
    }
    free(sp->cells);
    free(sp);
}