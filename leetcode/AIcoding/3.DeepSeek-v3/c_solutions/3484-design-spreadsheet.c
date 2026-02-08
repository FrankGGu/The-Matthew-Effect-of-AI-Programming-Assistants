typedef struct {
    char*** sheet;
    int rows;
    int cols;
} Excel;

Excel* excelCreate(int H, char W) {
    Excel* obj = (Excel*)malloc(sizeof(Excel));
    obj->rows = H;
    obj->cols = W - 'A' + 1;
    obj->sheet = (char***)malloc(obj->rows * sizeof(char**));
    for (int i = 0; i < obj->rows; i++) {
        obj->sheet[i] = (char**)malloc(obj->cols * sizeof(char*));
        for (int j = 0; j < obj->cols; j++) {
            obj->sheet[i][j] = (char*)calloc(10, sizeof(char));
            strcpy(obj->sheet[i][j], "0");
        }
    }
    return obj;
}

void excelSet(Excel* obj, int r, char c, char* v) {
    int col = c - 'A';
    int row = r - 1;
    free(obj->sheet[row][col]);
    obj->sheet[row][col] = (char*)malloc(strlen(v) + 1);
    strcpy(obj->sheet[row][col], v);
}

int excelGet(Excel* obj, int r, char c) {
    int col = c - 'A';
    int row = r - 1;
    return evaluate(obj, row, col);
}

int excelSum(Excel* obj, int r, char c, char** strs, int strsSize) {
    int col = c - 'A';
    int row = r - 1;
    char* formula = (char*)malloc(1000);
    formula[0] = '\0';
    strcat(formula, "=");
    for (int i = 0; i < strsSize; i++) {
        strcat(formula, strs[i]);
        if (i < strsSize - 1) strcat(formula, ",");
    }
    free(obj->sheet[row][col]);
    obj->sheet[row][col] = formula;
    return evaluate(obj, row, col);
}

void excelFree(Excel* obj) {
    for (int i = 0; i < obj->rows; i++) {
        for (int j = 0; j < obj->cols; j++) {
            free(obj->sheet[i][j]);
        }
        free(obj->sheet[i]);
    }
    free(obj->sheet);
    free(obj);
}

int evaluate(Excel* obj, int row, int col) {
    char* cell = obj->sheet[row][col];
    if (cell[0] != '=') {
        return atoi(cell);
    }

    int sum = 0;
    char* token = strtok(cell + 1, ",");
    while (token != NULL) {
        if (strchr(token, ':') != NULL) {
            char* range = token;
            char* colon = strchr(range, ':');
            *colon = '\0';
            char* start = range;
            char* end = colon + 1;

            int startRow, startCol, endRow, endCol;
            parseCell(start, &startRow, &startCol);
            parseCell(end, &endRow, &endCol);

            for (int i = startRow; i <= endRow; i++) {
                for (int j = startCol; j <= endCol; j++) {
                    sum += evaluate(obj, i, j);
                }
            }
        } else {
            int r, c;
            parseCell(token, &r, &c);
            sum += evaluate(obj, r, c);
        }
        token = strtok(NULL, ",");
    }
    return sum;
}

void parseCell(char* s, int* row, int* col) {
    *col = s[0] - 'A';
    *row = atoi(s + 1) - 1;
}