typedef struct {
    char* key;
    int val;
    UT_hash_handle hh;
} AtomMap;

AtomMap* atomMap = NULL;

void addAtom(char* atom, int count) {
    AtomMap* entry;
    HASH_FIND_STR(atomMap, atom, entry);
    if (entry) {
        entry->val += count;
    } else {
        entry = malloc(sizeof(AtomMap));
        entry->key = malloc(strlen(atom) + 1);
        strcpy(entry->key, atom);
        entry->val = count;
        HASH_ADD_KEYPTR(hh, atomMap, entry->key, strlen(entry->key), entry);
    }
}

int cmp(AtomMap* a, AtomMap* b) {
    return strcmp(a->key, b->key);
}

char* countOfAtoms(char* formula) {
    atomMap = NULL;
    int n = strlen(formula);
    int idx = 0;

    int* stack = malloc(n * sizeof(int));
    int top = -1;

    int i = 0;
    while (i < n) {
        if (formula[i] == '(') {
            stack[++top] = -1;
            i++;
        } else if (formula[i] == ')') {
            i++;
            int num = 0;
            while (i < n && isdigit(formula[i])) {
                num = num * 10 + (formula[i] - '0');
                i++;
            }
            if (num == 0) num = 1;

            int j = top;
            while (stack[j] != -1) j--;

            for (int k = j + 1; k <= top; k++) {
                stack[k] *= num;
            }
            top--;
        } else {
            char atom[100] = {0};
            int pos = 0;
            atom[pos++] = formula[i++];
            while (i < n && islower(formula[i])) {
                atom[pos++] = formula[i++];
            }
            atom[pos] = '\0';

            int num = 0;
            while (i < n && isdigit(formula[i])) {
                num = num * 10 + (formula[i] - '0');
                i++;
            }
            if (num == 0) num = 1;

            stack[++top] = num;

            char* atomCopy = malloc(strlen(atom) + 1);
            strcpy(atomCopy, atom);
            addAtom(atomCopy, num);
            free(atomCopy);
        }
    }

    free(stack);

    HASH_SORT(atomMap, cmp);

    char* result = malloc(10000);
    int pos = 0;
    AtomMap *current, *tmp;
    HASH_ITER(hh, atomMap, current, tmp) {
        int len = strlen(current->key);
        strcpy(result + pos, current->key);
        pos += len;
        if (current->val > 1) {
            char numStr[10];
            sprintf(numStr, "%d", current->val);
            int numLen = strlen(numStr);
            strcpy(result + pos, numStr);
            pos += numLen;
        }
        HASH_DEL(atomMap, current);
        free(current->key);
        free(current);
    }
    result[pos] = '\0';

    return result;
}