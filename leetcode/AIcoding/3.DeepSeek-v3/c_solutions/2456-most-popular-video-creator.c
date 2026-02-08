typedef struct {
    char* id;
    long long total_views;
    int max_views;
    char* max_id;
} Creator;

typedef struct {
    char* key;
    Creator* value;
    UT_hash_handle hh;
} HashItem;

char *** mostPopularCreator(char ** creators, int creatorsSize, char ** ids, int idsSize, int* views, int viewsSize, int* returnSize, int** returnColumnSizes) {
    HashItem* creator_map = NULL;
    long long max_popularity = LLONG_MIN;

    for (int i = 0; i < creatorsSize; i++) {
        HashItem* entry = NULL;
        HASH_FIND_STR(creator_map, creators[i], entry);

        if (entry == NULL) {
            Creator* new_creator = (Creator*)malloc(sizeof(Creator));
            new_creator->id = creators[i];
            new_creator->total_views = views[i];
            new_creator->max_views = views[i];
            new_creator->max_id = ids[i];

            HashItem* new_entry = (HashItem*)malloc(sizeof(HashItem));
            new_entry->key = creators[i];
            new_entry->value = new_creator;
            HASH_ADD_STR(creator_map, key, new_entry);
        } else {
            Creator* creator = entry->value;
            creator->total_views += views[i];
            if (views[i] > creator->max_views || 
                (views[i] == creator->max_views && strcmp(ids[i], creator->max_id) < 0)) {
                creator->max_views = views[i];
                creator->max_id = ids[i];
            }
        }
    }

    HashItem* curr, *tmp;
    HASH_ITER(hh, creator_map, curr, tmp) {
        if (curr->value->total_views > max_popularity) {
            max_popularity = curr->value->total_views;
        }
    }

    int count = 0;
    HASH_ITER(hh, creator_map, curr, tmp) {
        if (curr->value->total_views == max_popularity) {
            count++;
        }
    }

    char*** result = (char***)malloc(count * sizeof(char**));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int idx = 0;
    HASH_ITER(hh, creator_map, curr, tmp) {
        if (curr->value->total_views == max_popularity) {
            result[idx] = (char**)malloc(2 * sizeof(char*));
            result[idx][0] = curr->value->id;
            result[idx][1] = curr->value->max_id;
            (*returnColumnSizes)[idx] = 2;
            idx++;
        }
    }

    HASH_ITER(hh, creator_map, curr, tmp) {
        HASH_DEL(creator_map, curr);
        free(curr->value);
        free(curr);
    }

    return result;
}