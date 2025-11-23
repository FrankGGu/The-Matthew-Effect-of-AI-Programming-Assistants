#include <stdlib.h>
#include <string.h>

typedef struct {
    char **id_vars;
    int id_varsSize;
    char *var_name;
    char *value_name;
    char **value_vars;
    int value_varsSize;
} MeltInput;

typedef struct {
    char **data;
    int dataSize;
    int *dataColSize;
} ReturnMatrix;

ReturnMatrix* melt(MeltInput* input) {
    int num_id_vars = input->id_varsSize;
    int num_value_vars = input->value_varsSize;
    int total_rows = 1 + num_value_vars; // Header + data rows

    // Allocate memory for result
    ReturnMatrix* result = (ReturnMatrix*)malloc(sizeof(ReturnMatrix));
    result->data = (char**)malloc(total_rows * sizeof(char*));
    result->dataSize = total_rows;
    result->dataColSize = (int*)malloc(total_rows * sizeof(int));

    // Create header row
    int header_cols = num_id_vars + 2;
    result->data[0] = (char*)malloc((header_cols * 50) * sizeof(char));
    result->dataColSize[0] = header_cols;

    char* header = result->data[0];
    int pos = 0;

    // Add id_vars to header
    for (int i = 0; i < num_id_vars; i++) {
        pos += sprintf(header + pos, "%s", input->id_vars[i]);
        if (i < num_id_vars - 1) {
            pos += sprintf(header + pos, ",");
        }
    }

    // Add var_name and value_name to header
    pos += sprintf(header + pos, ",%s,%s", input->var_name, input->value_name);

    // Create data rows
    for (int i = 0; i < num_value_vars; i++) {
        int row_cols = num_id_vars + 2;
        result->data[i + 1] = (char*)malloc((row_cols * 50) * sizeof(char));
        result->dataColSize[i + 1] = row_cols;

        char* row = result->data[i + 1];
        int row_pos = 0;

        // Add id_vars values (using placeholders since actual data isn't provided)
        for (int j = 0; j < num_id_vars; j++) {
            row_pos += sprintf(row + row_pos, "val%d", j + 1);
            if (j < num_id_vars - 1) {
                row_pos += sprintf(row + row_pos, ",");
            }
        }

        // Add current value_var name and its value
        row_pos += sprintf(row + row_pos, ",%s,value%d", input->value_vars[i], i + 1);
    }

    return result;
}