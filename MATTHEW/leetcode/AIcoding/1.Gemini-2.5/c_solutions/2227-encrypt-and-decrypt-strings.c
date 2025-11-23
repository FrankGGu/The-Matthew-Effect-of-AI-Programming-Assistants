#include <stdlib.h>
#include <string.h>

#define MAX_KEYS_CHAR_RANGE 26

typedef struct StringCountNode {
    char* str;
    int count;
    struct StringCountNode* next;
} StringCountNode;

#define HASH_TABLE_BUCKETS 10007

typedef struct {
    char* key_to_value_map[MAX_KEYS_CHAR_RANGE];
    StringCountNode** encrypted_dictionary_counts;
} Encrypter;

unsigned int hash_string(const char* s) {
    unsigned int h = 5381;
    int c;
    while ((c = *s++)) {
        h = ((h << 5) + h) + c;
    }
    return h;
}

void add_to_hash_table(StringCountNode** table, const char* str) {
    unsigned int idx = hash_string(str) % HASH_TABLE_BUCKETS;
    StringCountNode* current = table[idx];
    while (current) {
        if (strcmp(current->str, str) == 0) {
            current->count++;
            return;
        }
        current = current->next;
    }
    StringCountNode* newNode = (StringCountNode*)malloc(sizeof(StringCountNode));
    newNode->str = strdup(str);
    newNode->count = 1;
    newNode->next = table[idx];
    table[idx] = newNode;
}

int get_from_hash_table(StringCountNode** table, const char* str) {
    unsigned int idx = hash_string(str) % HASH_TABLE_BUCKETS;
    StringCountNode* current = table[idx];
    while (current) {
        if (strcmp(current->str, str) == 0) {
            return current->count;
        }
        current = current->next;
    }
    return 0;
}

void free_hash_table(StringCountNode** table) {
    for (int i = 0; i < HASH_TABLE_BUCKETS; i++) {
        StringCountNode* current = table[i];
        while (current) {
            StringCountNode* temp = current;
            current = current->next;
            free(temp->str);
            free(temp);
        }
    }
    free(table);
}

char* encrypterEncrypt(Encrypter* obj, char* word1);

Encrypter* encrypterCreate(char *keys, char **values, int keysSize, char **dictionary, int dictionarySize) {
    Encrypter* obj = (Encrypter*)malloc(sizeof(Encrypter));

    for (int i = 0; i < MAX_KEYS_CHAR_RANGE; i++) {
        obj->key_to_value_map[i] = NULL;
    }
    for (int i = 0; i < keysSize; i++) {
        obj->key_to_value_map[keys[i] - 'a'] = values[i];
    }

    obj->encrypted_dictionary_counts = (StringCountNode**)calloc(HASH_TABLE_BUCKETS, sizeof(StringCountNode*));

    for (int i = 0; i < dictionarySize; i++) {
        char* encrypted_word = encrypterEncrypt(obj, dictionary[i]);
        if (strlen(encrypted_word) > 0) {
            add_to_hash_table(obj->encrypted_dictionary_counts, encrypted_word);
        }
        free(encrypted_word);
    }

    return obj;
}

char* encrypterEncrypt(Encrypter* obj, char* word1) {
    int len = strlen(word1);
    char* encrypted_str = (char*)malloc(sizeof(char) * (len * 100 + 1));
    encrypted_str[0] = '\0';

    char* current_pos = encrypted_str;
    for (int i = 0; i < len; i++) {
        char c = word1[i];
        if (obj->key_to_value_map[c - 'a'] == NULL) {
            free(encrypted_str);
            return strdup("");
        }
        char* mapped_value = obj->key_to_value_map[c - 'a'];
        strcpy(current_pos, mapped_value);
        current_pos += strlen(mapped_value);
    }
    *current_pos = '\0';

    return encrypted_str;
}

int encrypterDecrypt(Encrypter* obj, char* word2) {
    return get_from_hash_table(obj->encrypted_dictionary_counts, word2);
}

void encrypterFree(Encrypter* obj) {
    free_hash_table(obj->encrypted_dictionary_counts);
    free(obj);
}