#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *food;
    char *cuisine;
    int rating;
} Food;

typedef struct {
    Food *foods;
    int foodCount;
} FoodRatings;

FoodRatings* foodRatingsCreate(char** foods, int foodsSize, char** cuisines, int cuisinesSize, int* ratings, int ratingsSize) {
    FoodRatings *obj = (FoodRatings*)malloc(sizeof(FoodRatings));
    obj->foods = (Food*)malloc(sizeof(Food) * foodsSize);
    obj->foodCount = foodsSize;

    for (int i = 0; i < foodsSize; i++) {
        obj->foods[i].food = strdup(foods[i]);
        obj->foods[i].cuisine = strdup(cuisines[i]);
        obj->foods[i].rating = ratings[i];
    }

    return obj;
}

void foodRatingsChangeRating(FoodRatings* obj, char* food, int newRating) {
    for (int i = 0; i < obj->foodCount; i++) {
        if (strcmp(obj->foods[i].food, food) == 0) {
            obj->foods[i].rating = newRating;
            return;
        }
    }
}

char* foodRatingsHighestRated(FoodRatings* obj, char* cuisine) {
    int highestRating = -1;
    char *highestRatedFood = NULL;

    for (int i = 0; i < obj->foodCount; i++) {
        if (strcmp(obj->foods[i].cuisine, cuisine) == 0) {
            if (obj->foods[i].rating > highestRating) {
                highestRating = obj->foods[i].rating;
                highestRatedFood = obj->foods[i].food;
            } else if (obj->foods[i].rating == highestRating) {
                if (strcmp(obj->foods[i].food, highestRatedFood) < 0) {
                    highestRatedFood = obj->foods[i].food;
                }
            }
        }
    }

    return highestRatedFood;
}

void foodRatingsFree(FoodRatings* obj) {
    for (int i = 0; i < obj->foodCount; i++) {
        free(obj->foods[i].food);
        free(obj->foods[i].cuisine);
    }
    free(obj->foods);
    free(obj);
}