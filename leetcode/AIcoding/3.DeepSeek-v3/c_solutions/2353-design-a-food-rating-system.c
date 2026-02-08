#include <stdlib.h>
#include <string.h>

typedef struct Food {
    char* name;
    char* cuisine;
    int rating;
} Food;

typedef struct Node {
    Food* food;
    struct Node* next;
} Node;

typedef struct {
    Node** cuisineTable;
    int tableSize;
} FoodRatings;

FoodRatings* foodRatingsCreate(char** foods, int foodsSize, char** cuisines, int cuisinesSize, int* ratings, int ratingsSize) {
    FoodRatings* obj = (FoodRatings*)malloc(sizeof(FoodRatings));
    obj->tableSize = 1000;
    obj->cuisineTable = (Node**)calloc(obj->tableSize, sizeof(Node*));

    for (int i = 0; i < foodsSize; i++) {
        Food* newFood = (Food*)malloc(sizeof(Food));
        newFood->name = strdup(foods[i]);
        newFood->cuisine = strdup(cuisines[i]);
        newFood->rating = ratings[i];

        unsigned long hash = 0;
        char* p = cuisines[i];
        while (*p) {
            hash = (hash * 31 + *p) % obj->tableSize;
            p++;
        }

        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->food = newFood;
        newNode->next = obj->cuisineTable[hash];
        obj->cuisineTable[hash] = newNode;
    }

    return obj;
}

void foodRatingsChangeRating(FoodRatings* obj, char* food, int newRating) {
    for (int i = 0; i < obj->tableSize; i++) {
        Node* curr = obj->cuisineTable[i];
        while (curr) {
            if (strcmp(curr->food->name, food) == 0) {
                curr->food->rating = newRating;
                return;
            }
            curr = curr->next;
        }
    }
}

char* foodRatingsHighestRated(FoodRatings* obj, char* cuisine) {
    unsigned long hash = 0;
    char* p = cuisine;
    while (*p) {
        hash = (hash * 31 + *p) % obj->tableSize;
        p++;
    }

    Node* curr = obj->cuisineTable[hash];
    Food* highest = NULL;

    while (curr) {
        if (strcmp(curr->food->cuisine, cuisine) == 0) {
            if (highest == NULL || 
                curr->food->rating > highest->rating ||
                (curr->food->rating == highest->rating && strcmp(curr->food->name, highest->name) < 0)) {
                highest = curr->food;
            }
        }
        curr = curr->next;
    }

    return highest ? highest->name : "";
}

void foodRatingsFree(FoodRatings* obj) {
    for (int i = 0; i < obj->tableSize; i++) {
        Node* curr = obj->cuisineTable[i];
        while (curr) {
            Node* temp = curr;
            curr = curr->next;
            free(temp->food->name);
            free(temp->food->cuisine);
            free(temp->food);
            free(temp);
        }
    }
    free(obj->cuisineTable);
    free(obj);
}

/**
 * Your FoodRatings struct will be instantiated and called as such:
 * FoodRatings* obj = foodRatingsCreate(foods, foodsSize, cuisines, cuisinesSize, ratings, ratingsSize);
 * foodRatingsChangeRating(obj, food, newRating);
 * char* param_2 = foodRatingsHighestRated(obj, cuisine);
 * foodRatingsFree(obj);
*/