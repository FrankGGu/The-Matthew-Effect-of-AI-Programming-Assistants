#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Cell {
    char* value;
    int row;
    int col;
} Cell;

typedef struct Spreadsheet {
    int rows;
    int cols;
    Cell*** cells;
} Spreadsheet;

Spreadsheet* spreadsheetCreate(int height, int width) {
    Spreadsheet* s = (Spreadsheet*)malloc(sizeof(Spreadsheet));
    s->rows = height;
    s->cols = width;
    s->cells = (Cell***)malloc(height * sizeof(Cell**));
    for (int i = 0; i < height; i++) {
        s->cells[i] = (Cell**)malloc(width * sizeof(Cell*));
        for (int j = 0; j < width; j++) {
            s->cells[i][j] = (Cell*)malloc(sizeof(Cell));
            s->cells[i][j]->value = NULL;
            s->cells[i][j]->row = i;
            s->cells[i][j]->col = j;
        }
    }
    return s;
}

void spreadsheetSetVal(Spreadsheet* obj, int row, int col, char* val) {
    if (obj->cells[row][col]->value != NULL) {
        free(obj->cells[row][col]->value);
    }
    obj->cells[row][col]->value = strdup(val);
}

char* spreadsheetGetVal(Spreadsheet* obj, int row, int col) {
    return obj->cells[row][col]->value;
}

void spreadsheetFree(Spreadsheet* obj) {
    for (int i = 0; i < obj->rows; i++) {
        for (int j = 0; j < obj->cols; j++) {
            free(obj->cells[i][j]->value);
            free(obj->cells[i][j]);
        }
        free(obj->cells[i]);
    }
    free(obj->cells);
    free(obj);
}