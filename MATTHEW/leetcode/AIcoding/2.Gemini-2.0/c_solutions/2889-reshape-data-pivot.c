#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COLUMNS 256

typedef struct {
    char* pivot_column;
    char* value_column;
    char* index_column;
} pivot_config;

typedef struct {
    char** columns;
    char*** data;
    int num_columns;
    int num_rows;
} dataframe;

dataframe* pivot_data(dataframe* df, pivot_config* config) {
    int pivot_col_index = -1;
    int value_col_index = -1;
    int index_col_index = -1;

    for (int i = 0; i < df->num_columns; ++i) {
        if (strcmp(df->columns[i], config->pivot_column) == 0) {
            pivot_col_index = i;
        } else if (strcmp(df->columns[i], config->value_column) == 0) {
            value_col_index = i;
        } else if (strcmp(df->columns[i], config->index_column) == 0) {
            index_col_index = i;
        }
    }

    if (pivot_col_index == -1 || value_col_index == -1 || index_col_index == -1) {
        return NULL;
    }

    int num_unique_indexes = 0;
    char** unique_indexes = NULL;

    int num_unique_pivots = 0;
    char** unique_pivots = NULL;

    for (int i = 0; i < df->num_rows; ++i) {
        char* index_value = df->data[i][index_col_index];
        char* pivot_value = df->data[i][pivot_col_index];

        int index_found = 0;
        for (int j = 0; j < num_unique_indexes; ++j) {
            if (strcmp(unique_indexes[j], index_value) == 0) {
                index_found = 1;
                break;
            }
        }
        if (!index_found) {
            unique_indexes = (char**)realloc(unique_indexes, (num_unique_indexes + 1) * sizeof(char*));
            unique_indexes[num_unique_indexes] = strdup(index_value);
            num_unique_indexes++;
        }

        int pivot_found = 0;
        for (int j = 0; j < num_unique_pivots; ++j) {
            if (strcmp(unique_pivots[j], pivot_value) == 0) {
                pivot_found = 1;
                break;
            }
        }
        if (!pivot_found) {
            unique_pivots = (char**)realloc(unique_pivots, (num_unique_pivots + 1) * sizeof(char*));
            unique_pivots[num_unique_pivots] = strdup(pivot_value);
            num_unique_pivots++;
        }
    }

    qsort(unique_indexes, num_unique_indexes, sizeof(char*), (int (*)(const void *,const void *))strcmp);
    qsort(unique_pivots, num_unique_pivots, sizeof(char*), (int (*)(const void *,const void *))strcmp);

    dataframe* pivoted_df = (dataframe*)malloc(sizeof(dataframe));
    pivoted_df->num_columns = num_unique_pivots + 1;
    pivoted_df->num_rows = num_unique_indexes;

    pivoted_df->columns = (char**)malloc(pivoted_df->num_columns * sizeof(char*));
    pivoted_df->columns[0] = strdup(config->index_column);
    for(int i = 0; i < num_unique_pivots; ++i){
        pivoted_df->columns[i+1] = strdup(unique_pivots[i]);
    }

    pivoted_df->data = (char***)malloc(pivoted_df->num_rows * sizeof(char**));
    for(int i = 0; i < pivoted_df->num_rows; ++i){
        pivoted_df->data[i] = (char**)malloc(pivoted_df->num_columns * sizeof(char*));
        pivoted_df->data[i][0] = strdup(unique_indexes[i]);
        for(int j = 1; j < pivoted_df->num_columns; ++j){
            pivoted_df->data[i][j] = NULL; 
        }
    }

    for (int i = 0; i < df->num_rows; ++i) {
        char* index_value = df->data[i][index_col_index];
        char* pivot_value = df->data[i][pivot_col_index];
        char* value_value = df->data[i][value_col_index];

        int row_index = -1;
        for(int j = 0; j < num_unique_indexes; ++j){
            if(strcmp(unique_indexes[j], index_value) == 0){
                row_index = j;
                break;
            }
        }

        int col_index = -1;
        for(int j = 0; j < num_unique_pivots; ++j){
            if(strcmp(unique_pivots[j], pivot_value) == 0){
                col_index = j + 1;
                break;
            }
        }

        if(row_index != -1 && col_index != -1){
            pivoted_df->data[row_index][col_index] = strdup(value_value);
        }
    }

    for(int i = 0; i < num_unique_indexes; ++i){
        free(unique_indexes[i]);
    }
    free(unique_indexes);

    for(int i = 0; i < num_unique_pivots; ++i){
        free(unique_pivots[i]);
    }
    free(unique_pivots);

    return pivoted_df;
}