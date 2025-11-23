#include <stddef.h>
#include <stdlib.h>

struct Column {
    char* name;
    // For simplicity, we assume all columns store integers.
    // In a real DataFrame, this would be a void* and a type enum.
    int* data;
    size_t size; // Number of elements in this column
};

struct DataFrame {
    struct Column** columns;
    size_t numColumns;
    size_t numRows; // Number of rows in the DataFrame
};

struct DataFrameSize {
    int rows;
    int cols;
};

struct DataFrameSize getDataFrameSize(struct DataFrame* df) {
    struct DataFrameSize result;
    if (df == NULL) {
        result.rows = 0;
        result.cols = 0;
        return result;
    }

    result.rows = (int)df->numRows;
    result.cols = (int)df->numColumns;
    return result;
}