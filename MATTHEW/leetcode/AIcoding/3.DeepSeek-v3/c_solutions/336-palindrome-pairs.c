/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

typedef struct {
    char* key;
    int val;
    UT_hash_handle hh;
} HashItem;

bool isPalindrome(char* s, int left, int right) {
    while (left < right) {
        if (s[left++] != s[right--]) {
            return false;
        }
    }
    return true;
}

HashItem* find(HashItem** obj, char* key) {
    HashItem* pEntry = NULL;
    HASH_FIND_STR(*obj, key, pEntry);
    return pEntry;
}

bool insert(HashItem** obj, char* key, int val) {
    HashItem* pEntry = find(obj, key);
    if (pEntry) {
        return false;
    }
    pEntry = malloc(sizeof(HashItem));
    pEntry->key = key;
    pEntry->val = val;
    HASH_ADD_STR(*obj, key, pEntry);
    return true;
}

void freeHash(HashItem** obj) {
    HashItem *curr = NULL, *tmp = NULL;
    HASH_ITER(hh, *obj, curr, tmp) {
        HASH_DEL(*obj, curr);
        free(curr);
    }
}

int** palindromePairs(char** words, int wordsSize, int* returnSize, int** returnColumnSizes) {
    HashItem* indices = NULL;
    for (int i = 0; i < wordsSize; i++) {
        insert(&indices, words[i], i);
    }

    int** ret = malloc(sizeof(int*) * wordsSize * (wordsSize - 1));
    *returnColumnSizes = malloc(sizeof(int) * wordsSize * (wordsSize - 1));
    int pos = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int m = strlen(word);
        char str[m + 1];
        for (int j = 0; j <= m; j++) {
            if (isPalindrome(word, j, m - 1)) {
                int left_len = j;
                strncpy(str, word, left_len);
                str[left_len] = '\0';
                strrev(str);
                HashItem* pEntry = find(&indices, str);
                if (pEntry && pEntry->val != i) {
                    int* tmp = malloc(sizeof(int) * 2);
                    tmp[0] = i;
                    tmp[1] = pEntry->val;
                    ret[pos] = tmp;
                    (*returnColumnSizes)[pos++] = 2;
                }
            }
            if (j && isPalindrome(word, 0, j - 1)) {
                int right_len = m - j;
                strncpy(str, word + j, right_len);
                str[right_len] = '\0';
                strrev(str);
                HashItem* pEntry = find(&indices, str);
                if (pEntry && pEntry->val != i) {
                    int* tmp = malloc(sizeof(int) * 2);
                    tmp[0] = pEntry->val;
                    tmp[1] = i;
                    ret[pos] = tmp;
                    (*returnColumnSizes)[pos++] = 2;
                }
            }
        }
    }

    freeHash(&indices);
    *returnSize = pos;
    return ret;
}