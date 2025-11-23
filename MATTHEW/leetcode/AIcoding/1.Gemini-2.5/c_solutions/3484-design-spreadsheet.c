#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct {
    char* original_val_str;
    int cached_val;
    bool is_formula;
    bool evaluating;
    int last_evaluation_cycle_id;
} Cell;

typedef struct {
    int height;
    int width;
    Cell** grid;
    int current_evaluation_cycle_id;
} Spreadsheet;

int _spreadsheetGet(Spreadsheet* obj, int row, int col);
void parse_cell_ref(const char* s, int* r, int* c);
int parse_expression(Spreadsheet* obj, const char** formula_ptr);
int parse_term(Spreadsheet* obj, const char** formula_ptr);
int parse_factor(Spreadsheet* obj, const char** formula_ptr);
int get_operand_value(Spreadsheet* obj, const char** formula_ptr);

void parse_cell_ref(const char* s, int* r, int* c) {
    *c = 0;
    while (isalpha(*s)) {
        *c = *c * 26 + (*s - 'A' + 1);
        s++;
    }
    *c -= 1;

    *r = atoi(s) - 1;
}

int get_operand_value(Spreadsheet* obj, const char** formula_ptr) {
    while (**formula_ptr == ' ') {
        (*formula_ptr)++;
    }

    if (isdigit(**formula_ptr) || (**formula_ptr == '-' && isdigit(*(*formula_ptr + 1)))) {
        char* endptr;
        long val = strtol(*formula_ptr, &endptr, 10);
        *formula_ptr = endptr;
        return (int)val;
    } else if (isalpha(**formula_ptr)) {
        char cell_ref_buf[10];
        int i = 0;
        const char* start_ptr = *formula_ptr;
        while (isalpha(*start_ptr) || isdigit(*start_ptr)) {
            cell_ref_buf[i++] = *start_ptr;
            start_ptr++;
            if (i >= sizeof(cell_ref_buf) - 1) break;
        }
        cell_ref_buf[i] = '\0';
        *formula_ptr = start_ptr;

        int r, c;
        parse_cell_ref(cell_ref_buf, &r, &c);
        return _spreadsheetGet(obj, r, c);
    }
    return 0;
}

int parse_factor(Spreadsheet* obj, const char** formula_ptr) {
    return get_operand_value(obj, formula_ptr);
}

int parse_term(Spreadsheet* obj, const char** formula_ptr) {
    int result = parse_factor(obj, formula_ptr);
    while (true) {
        while (**formula_ptr == ' ') {
            (*formula_ptr)++;
        }
        char op = **formula_ptr;
        if (op == '*' || op == '/') {
            (*formula_ptr)++;
            int next_factor = parse_factor(obj, formula_ptr);
            if (op == '*') {
                result *= next_factor;
            } else {
                if (next_factor == 0) {
                    return 0;
                }
                result /= next_factor;
            }
        } else {
            break;
        }
    }
    return result;
}

int parse_expression(Spreadsheet* obj, const char** formula_ptr) {
    int result = parse_term(obj, formula_ptr);
    while (true) {
        while (**formula_ptr == ' ') {
            (*formula_ptr)++;
        }
        char op = **formula_ptr;
        if (op == '+' || op == '-') {
            (*formula_ptr)++;
            int next_term = parse_term(obj, formula_ptr);
            if (op == '+') {
                result += next_term;
            } else {
                result -= next_term;
            }
        } else {
            break;
        }
    }
    return result;
}

int _spreadsheetGet(Spreadsheet* obj, int row, int col) {
    if (row < 0 || row >= obj->height || col < 0 || col >= obj->width) {
        return 0;
    }

    Cell* cell = &obj->grid[row][col];

    if (cell->evaluating) {
        return 0;
    }

    if (cell->last_evaluation_cycle_id == obj->current_evaluation_cycle_id) {
        return cell->cached_val;
    }

    cell->evaluating = true;
    int result;

    if (cell->is_formula) {
        const char* formula_ptr = cell->original_val_str + 1;
        result = parse_expression(obj, &formula_ptr);
    } else {
        result = atoi(cell->original_val_str);
    }

    cell->cached_val = result;
    cell->last_evaluation_cycle_id = obj->current_evaluation_cycle_id;
    cell->evaluating = false;

    return result;
}

Spreadsheet* spreadsheetCreate(int height, int width) {
    Spreadsheet* obj = (Spreadsheet*)malloc(sizeof(Spreadsheet));
    obj->height = height;
    obj->width = width;
    obj->current_evaluation_cycle_id = 0;

    obj->grid = (Cell**)malloc(height * sizeof(Cell*));
    for (int r = 0; r < height; r++) {
        obj->grid[r] = (Cell*)malloc(width * sizeof(Cell));
        for (int c = 0; c < width; c++) {
            obj->grid[r][c].original_val_str = NULL;
            obj->grid[r][c].cached_val = 0;
            obj->grid[r][c].is_formula = false;
            obj->grid[r][c].evaluating = false;
            obj->grid[r][c].last_evaluation_cycle_id = 0;
        }
    }
    return obj;
}

void spreadsheetSet(Spreadsheet* obj, int row, int col, char* val) {
    if (row < 0 || row >= obj->height || col < 0 || col >= obj->width) {
        return;
    }

    Cell* cell = &obj->grid[row][col];

    if (cell->original_val_str != NULL) {
        free(cell->original_val_str);
    }
    cell->original_val_str = strdup(val);
    cell->is_formula = (val[0] == '=');
}

int spreadsheetGet(Spreadsheet* obj, int row, int col) {
    obj->current_evaluation_cycle_id++;
    return _spreadsheetGet(obj, row, col);
}

void spreadsheetFree(Spreadsheet* obj) {
    if (obj == NULL) return;

    for (int r = 0; r < obj->height; r++) {
        for (int c = 0; c < obj->width; c++) {
            if (obj->grid[r][c].original_val_str != NULL) {
                free(obj->grid[r][c].original_val_str);
            }
        }
        free(obj->grid[r]);
    }
    free(obj->grid);
    free(obj);
}