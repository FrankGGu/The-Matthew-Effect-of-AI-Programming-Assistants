void renameColumns(char*** table, int tableSize, int* tableColSize, char** columnNames, int columnNamesSize) {
    for (int i = 0; i < columnNamesSize; i++) {
        for (int j = 0; j < tableSize; j++) {
            if (strcmp(table[j][i], columnNames[i]) == 0) {
                free(table[j][i]);
                table[j][i] = strdup(columnNames[i]);
            }
        }
    }
}