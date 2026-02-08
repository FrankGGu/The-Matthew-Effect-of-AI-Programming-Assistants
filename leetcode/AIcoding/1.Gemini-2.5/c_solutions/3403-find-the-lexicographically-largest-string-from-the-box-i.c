#include <stdlib.h> // For malloc, qsort
#include <string.h> // For strlen (not strictly needed for this solution)

int compareCharsDescending(const void *a, const void *b) {
    return *(char*)b - *(char*)a;
}

char* findLexicographicallyLargestString(char** box, int boxSize, int* boxColSize) {
    int rows = boxSize;
    if (rows == 0) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }
    int cols = boxColSize[0];
    if (cols == 0) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    char** tilted_box = (char**)malloc(rows * sizeof(char*));
    for (int i = 0; i < rows; i++) {
        tilted_box[i] = (char*)malloc(cols * sizeof(char));
    }

    for (int j = 0; j < cols; j++) {
        char* temp_column_chars = (char*)malloc(rows * sizeof(char));
        int char_count = 0;
        for (int i = 0; i < rows; i++) {
            if (box[i][j] != '.') {
                temp_column_chars[char_count++] = box[i][j];
            }
        }

        qsort(temp_column_chars, char_count, sizeof(char), compareCharsDescending);

        for (int i = 0; i < rows; i++) {
            if (i < char_count) {
                tilted_box[i][j] = temp_column_chars[i];
            } else {
                tilted_box[i][j] = '.';
            }
        }
        free(temp_column_chars);
    }

    char* result_string = (char*)malloc(rows * cols + 1);
    int current_pos = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result_string[current_pos++] = tilted_box[i][j];
        }
    }
    result_string[current_pos] = '\0';

    for (int i = 0; i < rows; i++) {
        free(tilted_box[i]);
    }
    free(tilted_box);

    return result_string;
}