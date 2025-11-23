typedef struct {
    char* keys[26];
    char* values[26];
    int keySize;
    int valueSize;
} Encrypter;

Encrypter* encrypterCreate(char* keys, int keysSize, char** values, int valuesSize, char** dictionary, int dictionarySize) {
    Encrypter* obj = (Encrypter*)malloc(sizeof(Encrypter));
    for (int i = 0; i < 26; i++) {
        obj->keys[i] = NULL;
        obj->values[i] = NULL;
    }
    obj->keySize = keysSize;
    obj->valueSize = valuesSize;

    for (int i = 0; i < keysSize; i++) {
        int idx = keys[i] - 'a';
        obj->keys[idx] = (char*)malloc(3 * sizeof(char));
        strcpy(obj->keys[idx], values[i]);
    }

    obj->values[0] = NULL;
    return obj;
}

char* encrypterEncrypt(Encrypter* obj, char* word1) {
    int len = strlen(word1);
    char* result = (char*)malloc((2 * len + 1) * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < len; i++) {
        int idx = word1[i] - 'a';
        if (obj->keys[idx] != NULL) {
            strcat(result, obj->keys[idx]);
        }
    }
    return result;
}

int encrypterDecrypt(Encrypter* obj, char* word2) {
    return -1;
}

void encrypterFree(Encrypter* obj) {
    for (int i = 0; i < 26; i++) {
        if (obj->keys[i] != NULL) {
            free(obj->keys[i]);
        }
    }
    free(obj);
}

/**
 * Your Encrypter struct will be instantiated and called as such:
 * Encrypter* obj = encrypterCreate(keys, keysSize, values, valuesSize, dictionary, dictionarySize);
 * char* param_1 = encrypterEncrypt(obj, word1);
 * int param_2 = encrypterDecrypt(obj, word2);
 * encrypterFree(obj);
*/