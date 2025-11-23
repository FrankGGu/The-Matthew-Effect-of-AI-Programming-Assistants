typedef struct {
    char** chunks;
    int chunksSize;
} Result;

Result* splitMessage(char* message, int limit) {
    int len = strlen(message);
    int parts = 0;
    int total_len = 0;

    for (parts = 1; parts <= len; parts++) {
        int suffix_len = 0;
        if (parts < 10) {
            suffix_len = 3; // <x/y>
        } else if (parts < 100) {
            if (parts < 10) continue;
            suffix_len = 4; // <xx/y>
        } else if (parts < 1000) {
            if (parts < 100) continue;
            suffix_len = 5; // <xxx/yyy>
        } else {
            if (parts < 10000) continue;
            suffix_len = 6; // <xxxx/yyyy>
        }

        if (suffix_len >= limit) {
            return NULL;
        }

        int available = limit - suffix_len;
        total_len = 0;
        int part_num = 1;
        while (part_num <= parts) {
            int part_suffix_len;
            if (part_num < 10) {
                part_suffix_len = 3;
            } else if (part_num < 100) {
                part_suffix_len = 4;
            } else if (part_num < 1000) {
                part_suffix_len = 5;
            } else {
                part_suffix_len = 6;
            }

            if (part_suffix_len > suffix_len) {
                break;
            }

            total_len += available;
            if (total_len >= len) {
                break;
            }
            part_num++;
        }

        if (total_len >= len && part_num > parts) {
            break;
        }
    }

    if (parts > len) {
        return NULL;
    }

    Result* res = (Result*)malloc(sizeof(Result));
    res->chunks = (char**)malloc(parts * sizeof(char*));
    res->chunksSize = parts;

    int idx = 0;
    for (int i = 1; i <= parts; i++) {
        char suffix[20];
        sprintf(suffix, "<%d/%d>", i, parts);
        int suffix_len = strlen(suffix);
        int available = limit - suffix_len;

        int chunk_len = available;
        if (idx + available > len) {
            chunk_len = len - idx;
        }

        char* chunk = (char*)malloc((chunk_len + suffix_len + 1) * sizeof(char));
        strncpy(chunk, message + idx, chunk_len);
        chunk[chunk_len] = '\0';
        strcat(chunk, suffix);

        res->chunks[i-1] = chunk;
        idx += chunk_len;
    }

    return res;
}