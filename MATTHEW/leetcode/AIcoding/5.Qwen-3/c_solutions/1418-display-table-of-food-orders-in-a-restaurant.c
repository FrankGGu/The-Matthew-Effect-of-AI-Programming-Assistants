#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char* key;
    int count;
} Pair;

typedef struct {
    char** data;
    int size;
} StringList;

typedef struct {
    StringList* headers;
    StringList* rows;
} Table;

char* strdup(const char* s) {
    char* result = (char*)malloc(strlen(s) + 1);
    if (result) strcpy(result, s);
    return result;
}

void freeStringList(StringList* list) {
    if (!list) return;
    for (int i = 0; i < list->size; i++) free(list->data[i]);
    free(list->data);
    free(list);
}

void freeTable(Table* table) {
    if (!table) return;
    freeStringList(table->headers);
    for (int i = 0; i < table->rows->size; i++) freeStringList(table->rows->data[i]);
    freeStringList(table->rows);
    free(table);
}

Table* createTable() {
    Table* table = (Table*)malloc(sizeof(Table));
    table->headers = (StringList*)malloc(sizeof(StringList));
    table->headers->data = NULL;
    table->headers->size = 0;
    table->rows = (StringList*)malloc(sizeof(StringList));
    table->rows->data = NULL;
    table->rows->size = 0;
    return table;
}

void addHeader(Table* table, const char* header) {
    int index = -1;
    for (int i = 0; i < table->headers->size; i++) {
        if (strcmp(table->headers->data[i], header) == 0) {
            index = i;
            break;
        }
    }
    if (index == -1) {
        StringList* newHeaders = (StringList*)malloc(sizeof(StringList));
        newHeaders->data = (char**)malloc((table->headers->size + 1) * sizeof(char*));
        for (int i = 0; i < table->headers->size; i++) newHeaders->data[i] = table->headers->data[i];
        newHeaders->data[table->headers->size] = strdup(header);
        newHeaders->size = table->headers->size + 1;
        freeStringList(table->headers);
        table->headers = newHeaders;
    }
}

void addRow(Table* table, const char* food, int quantity) {
    int rowIndex = -1;
    for (int i = 0; i < table->rows->size; i++) {
        if (strcmp(table->rows->data[i]->data[0], food) == 0) {
            rowIndex = i;
            break;
        }
    }
    if (rowIndex == -1) {
        StringList* newRow = (StringList*)malloc(sizeof(StringList));
        newRow->data = (char**)malloc((table->headers->size + 1) * sizeof(char*));
        newRow->data[0] = strdup(food);
        for (int i = 1; i < table->headers->size + 1; i++) {
            newRow->data[i] = strdup("0");
        }
        newRow->size = table->headers->size + 1;
        StringList* newRows = (StringList*)malloc(sizeof(StringList));
        newRows->data = (char**)malloc((table->rows->size + 1) * sizeof(char*));
        for (int i = 0; i < table->rows->size; i++) newRows->data[i] = table->rows->data[i];
        newRows->data[table->rows->size] = (char*)newRow;
        newRows->size = table->rows->size + 1;
        freeStringList(table->rows);
        table->rows = newRows;
    } else {
        for (int i = 1; i < table->headers->size + 1; i++) {
            if (strcmp(table->headers->data[i - 1], food) == 0) {
                int current = atoi(table->rows->data[rowIndex]->data[i]);
                current += quantity;
                free(table->rows->data[rowIndex]->data[i]);
                table->rows->data[rowIndex]->data[i] = strdup(itoa(current, (char*)malloc(10), 10));
                break;
            }
        }
    }
}

char** displayTable(int n, char** str, int* returnSize, int** returnColumnSizes) {
    Table* table = createTable();
    for (int i = 0; i < n; i++) {
        char* token = strtok(str[i], " ");
        char* person = token;
        token = strtok(NULL, " ");
        char* food = token;
        token = strtok(NULL, " ");
        int quantity = atoi(token);
        addHeader(table, food);
        addRow(table, food, quantity);
    }

    *returnSize = table->rows->size + 1;
    *returnColumnSizes = (int*)malloc((*returnSize) * sizeof(int));
    (*returnColumnSizes)[0] = table->headers->size + 1;
    for (int i = 1; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = table->headers->size + 1;
    }

    char** result = (char**)malloc((*returnSize) * sizeof(char*));
    result[0] = (char*)malloc((table->headers->size + 1) * sizeof(char*));
    result[0][0] = ' ';
    for (int i = 0; i < table->headers->size; i++) {
        result[0][i + 1] = '\0';
        strcat(result[0], table->headers->data[i]);
    }

    for (int i = 1; i < *returnSize; i++) {
        StringList* row = table->rows->data[i - 1];
        result[i] = (char*)malloc((table->headers->size + 1) * sizeof(char*));
        result[i][0] = '\0';
        strcat(result[i], row->data[0]);
        for (int j = 1; j < table->headers->size + 1; j++) {
            strcat(result[i], ",");
            strcat(result[i], row->data[j]);
        }
    }

    freeTable(table);
    return result;
}