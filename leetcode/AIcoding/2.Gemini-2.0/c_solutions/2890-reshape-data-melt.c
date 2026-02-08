#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct DataFrame {
    int *data;
    int numRows;
    int numCols;
};

struct DataFrame melt(struct DataFrame df, int id_vars[], int num_id_vars) {
    int num_value_vars = df.numCols - num_id_vars;
    int num_melted_rows = df.numRows * num_value_vars;

    struct DataFrame melted_df;
    melted_df.numRows = num_melted_rows;
    melted_df.numCols = num_id_vars + 2; 
    melted_df.data = (int *)malloc(melted_df.numRows * melted_df.numCols * sizeof(int));

    int *melted_data = melted_df.data;
    int melted_row_index = 0;

    for (int i = 0; i < df.numRows; i++) {
        for (int j = 0; j < df.numCols; j++) {
            int is_id_var = 0;
            for (int k = 0; k < num_id_vars; k++) {
                if (id_vars[k] == j) {
                    is_id_var = 1;
                    break;
                }
            }

            if (!is_id_var) {

                for (int k = 0; k < num_id_vars; k++) {
                    melted_data[melted_row_index * melted_df.numCols + k] = df.data[i * df.numCols + id_vars[k]];
                }

                melted_data[melted_row_index * melted_df.numCols + num_id_vars] = j;
                melted_data[melted_row_index * melted_df.numCols + num_id_vars + 1] = df.data[i * df.numCols + j];

                melted_row_index++;
            }
        }
    }

    return melted_df;
}