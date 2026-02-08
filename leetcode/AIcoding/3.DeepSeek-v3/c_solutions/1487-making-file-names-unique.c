typedef struct {
    char* name;
    int count;
    UT_hash_handle hh;
} FileEntry;

char** getFolderNames(char** names, int namesSize, int* returnSize) {
    char** result = (char**)malloc(namesSize * sizeof(char*));
    *returnSize = namesSize;
    FileEntry* map = NULL;

    for (int i = 0; i < namesSize; i++) {
        FileEntry* entry = NULL;
        HASH_FIND_STR(map, names[i], entry);

        if (entry == NULL) {
            result[i] = (char*)malloc((strlen(names[i]) + 1) * sizeof(char));
            strcpy(result[i], names[i]);

            entry = (FileEntry*)malloc(sizeof(FileEntry));
            entry->name = result[i];
            entry->count = 0;
            HASH_ADD_KEYPTR(hh, map, entry->name, strlen(entry->name), entry);
        } else {
            int k = entry->count + 1;
            char* newName = NULL;

            while (1) {
                int len = strlen(names[i]) + 10;
                newName = (char*)malloc(len * sizeof(char));
                sprintf(newName, "%s(%d)", names[i], k);

                FileEntry* tmp = NULL;
                HASH_FIND_STR(map, newName, tmp);
                if (tmp == NULL) {
                    break;
                }
                free(newName);
                k++;
            }

            result[i] = newName;
            entry->count = k;

            FileEntry* newEntry = (FileEntry*)malloc(sizeof(FileEntry));
            newEntry->name = result[i];
            newEntry->count = 0;
            HASH_ADD_KEYPTR(hh, map, newEntry->name, strlen(newEntry->name), newEntry);
        }
    }

    FileEntry *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current);
    }

    return result;
}