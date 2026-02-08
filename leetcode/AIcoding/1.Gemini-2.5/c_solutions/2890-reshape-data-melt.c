#include <stdlib.h>
#include <string.h>

static int findColumnIndex(char** headers, int numHeaders, char* colName) {
    for (int i = 0; i < numHeaders; i++) {
        if (strcmp(headers[i], colName) == 0) {
            return i;
        }
    }
    return -1; // Not found
}

char*** melt(char*** data, int dataSize, int* dataColSizes, char** id_vars, int id_varsSize, char** value_vars, int value_varsSize, char* variable_name, char* value_name, int* returnSize, int** returnColumnSizes) {
    if (dataSize <= 0 || dataColSizes == NULL || dataColSizes[0] == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int numOriginalCols = dataColSizes[0];
    char** headers = data[0];

    int* id_col_indices = (int*)malloc(sizeof(int) * id_varsSize);
    for (int i = 0; i < id_varsSize; i++) {
        id_col_indices[i] = findColumnIndex(headers, numOriginalCols, id_vars[i]);
    }

    int* val_col_indices = NULL;
    int actual_value_vars_count = 0;

    if (value_vars == NULL || value_varsSize == 0) {
        val_col_indices = (int*)malloc(sizeof(int) * numOriginalCols);
        for (int i = 0; i < numOriginalCols; i++) {
            int is_id_var = 0;
            for (int j = 0; j < id_varsSize; j++) {
                if (id_col_indices[j] == i) {
                    is_id_var = 1;
                    break;
                }
            }
            if (!is_id_var) {
                val_col_indices[actual_value_vars_count++] = i;
            }
        }
        if (actual_value_vars_count == 0) {
            free(val_col_indices);
            val_col_indices = NULL;
        } else {
            val_col_indices = (int*)realloc(val_col_indices, sizeof(int) * actual_value_vars_count);
        }
    } else {
        val_col_indices = (int*)malloc(sizeof(int) * value_varsSize);
        for (int i = 0; i < value_varsSize; i++) {
            val_col_indices[actual_value_vars_count++] = findColumnIndex(headers, numOriginalCols, value_vars[i]);
        }
    }

    int numDataRows = dataSize - 1;
    *returnSize = numDataRows * actual_value_vars_count + 1;
    int numOutputCols = id_varsSize + 2;

    char*** result = (char***)malloc(sizeof(char**) * (*returnSize));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (*returnSize));

    result[0] = (char**)malloc(sizeof(char*) * numOutputCols);
    (*returnColumnSizes)[0] = numOutputCols;
    int current_output_col = 0;
    for (int i = 0; i < id_varsSize; i++) {
        result[0][current_output_col++] = strdup(id_vars[i]);
    }
    result[0][current_output_col++] = strdup(variable_name);
    result[0][current_output_col++] = strdup(value_name);

    int output_row_idx = 1;
    for (int i = 1; i < dataSize; i++) {
        char** original_data_row = data[i];

        for (int j = 0; j < actual_value_vars_count; j++) {
            int val_col_idx = val_col_indices[j];
            char* val_col_name = headers[val_col_idx];
            char* cell_value = original_data_row[val_col_idx];

            result[output_row_idx] = (char**)malloc(sizeof(char*) * numOutputCols);
            (*returnColumnSizes)[output_row_idx] = numOutputCols;
            current_output_col = 0;

            for (int k = 0; k < id_varsSize; k++) {
                result[output_row_idx][current_output_col++] = strdup(original_data_row[id_col_indices[k]]);
            }

            result[output_row_idx][current_output_col++] = strdup(val_col_name);
            result[output_row_idx][current_output_col++] = strdup(cell_value);

            output_row_idx++;
        }
    }

    free(id_col_indices);
    if (val_col_indices != NULL) {
        free(val_col_indices);
    }

    return result;
}