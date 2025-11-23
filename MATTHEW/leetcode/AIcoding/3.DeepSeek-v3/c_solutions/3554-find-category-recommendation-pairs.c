#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* user1;
    char* user2;
    char* category;
} Pair;

typedef struct {
    char* user;
    char* category;
} UserCategory;

int comparePairs(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;

    int user1_cmp = strcmp(pa->user1, pb->user1);
    if (user1_cmp != 0) return user1_cmp;

    int user2_cmp = strcmp(pa->user2, pb->user2);
    if (user2_cmp != 0) return user2_cmp;

    return strcmp(pa->category, pb->category);
}

char*** findCategoryRecommendationPairs(char*** user1_categories, int user1_categoriesSize, int* user1_categoriesColSize,
                                      char*** user2_categories, int user2_categoriesSize, int* user2_categoriesColSize,
                                      int* returnSize, int** returnColumnSizes) {

    UserCategory* uc1 = (UserCategory*)malloc(user1_categoriesSize * sizeof(UserCategory));
    UserCategory* uc2 = (UserCategory*)malloc(user2_categoriesSize * sizeof(UserCategory));

    for (int i = 0; i < user1_categoriesSize; i++) {
        uc1[i].user = user1_categories[i][0];
        uc1[i].category = user1_categories[i][1];
    }

    for (int i = 0; i < user2_categoriesSize; i++) {
        uc2[i].user = user2_categories[i][0];
        uc2[i].category = user2_categories[i][1];
    }

    Pair* pairs = (Pair*)malloc(user1_categoriesSize * user2_categoriesSize * sizeof(Pair));
    int pairCount = 0;

    for (int i = 0; i < user1_categoriesSize; i++) {
        for (int j = 0; j < user2_categoriesSize; j++) {
            if (strcmp(uc1[i].category, uc2[j].category) == 0) {
                if (strcmp(uc1[i].user, uc2[j].user) < 0) {
                    pairs[pairCount].user1 = uc1[i].user;
                    pairs[pairCount].user2 = uc2[j].user;
                } else {
                    pairs[pairCount].user1 = uc2[j].user;
                    pairs[pairCount].user2 = uc1[i].user;
                }
                pairs[pairCount].category = uc1[i].category;
                pairCount++;
            }
        }
    }

    if (pairCount == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        free(uc1);
        free(uc2);
        free(pairs);
        return NULL;
    }

    qsort(pairs, pairCount, sizeof(Pair), comparePairs);

    char*** result = (char***)malloc(pairCount * sizeof(char**));
    *returnColumnSizes = (int*)malloc(pairCount * sizeof(int));

    for (int i = 0; i < pairCount; i++) {
        result[i] = (char**)malloc(3 * sizeof(char*));
        result[i][0] = strdup(pairs[i].user1);
        result[i][1] = strdup(pairs[i].user2);
        result[i][2] = strdup(pairs[i].category);
        (*returnColumnSizes)[i] = 3;
    }

    *returnSize = pairCount;

    free(uc1);
    free(uc2);
    free(pairs);

    return result;
}