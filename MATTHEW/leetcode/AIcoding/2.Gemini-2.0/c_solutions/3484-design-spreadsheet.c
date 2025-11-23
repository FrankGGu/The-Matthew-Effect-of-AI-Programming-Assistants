#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char formula[100];
    int value;
    bool is_formula;
} Cell;

typedef struct {
    Cell** cells;
    int rows;
    int cols;
} Spreadsheet;

Spreadsheet* spreadsheetCreate(int rows, int cols) {
    Spreadsheet* spreadsheet = (Spreadsheet*)malloc(sizeof(Spreadsheet));
    spreadsheet->rows = rows;
    spreadsheet->cols = cols;
    spreadsheet->cells = (Cell**)malloc(rows * sizeof(Cell*));
    for (int i = 0; i < rows; i++) {
        spreadsheet->cells[i] = (Cell*)malloc(cols * sizeof(Cell));
        for (int j = 0; j < cols; j++) {
            spreadsheet->cells[i][j].formula[0] = '\0';
            spreadsheet->cells[i][j].value = 0;
            spreadsheet->cells[i][j].is_formula = false;
        }
    }
    return spreadsheet;
}

void spreadsheetSet(Spreadsheet* obj, int row, int col, char* contents) {
    if (obj == NULL || row < 0 || row >= obj->rows || col < 0 || col >= obj->cols) {
        return;
    }

    if (contents[0] == '=') {
        obj->cells[row][col].is_formula = true;
        strcpy(obj->cells[row][col].formula, contents);
    } else {
        obj->cells[row][col].is_formula = false;
        obj->cells[row][col].value = atoi(contents);
        obj->cells[row][col].formula[0] = '\0';
    }
}

int evaluate(Spreadsheet* obj, int row, int col, int* visited, int visitedSize) {
    if (row < 0 || row >= obj->rows || col < 0 || col >= obj->cols) {
        return 0;
    }

    for(int i = 0; i < visitedSize; i++){
        if(visited[i] == row * obj->cols + col) return 0;
    }

    if (!obj->cells[row][col].is_formula) {
        return obj->cells[row][col].value;
    }

    char* formula = obj->cells[row][col].formula + 1;
    int sum = 0;
    char* token = strtok(formula, "+");
    while (token != NULL) {
        int r, c;
        sscanf(token, "%d%d", &r, &c);
        r--;
        c--;

        visited[visitedSize] = row * obj->cols + col;
        sum += evaluate(obj, r, c, visited, visitedSize + 1);
        token = strtok(NULL, "+");
    }
    return sum;
}

int spreadsheetGet(Spreadsheet* obj, int row, int col) {
    if (obj == NULL || row < 0 || row >= obj->rows || col < 0 || col >= obj->cols) {
        return 0;
    }

    int* visited = (int*)malloc(obj->rows * obj->cols * sizeof(int));
    int result = evaluate(obj, row, col, visited, 0);
    free(visited);
    return result;
}

void spreadsheetFree(Spreadsheet* obj) {
    if (obj == NULL) {
        return;
    }
    for (int i = 0; i < obj->rows; i++) {
        free(obj->cells[i]);
    }
    free(obj->cells);
    free(obj);
}