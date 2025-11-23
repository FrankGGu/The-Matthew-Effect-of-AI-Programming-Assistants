#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* cuisine;
    char* food;
    int rating;
} Food;

typedef struct {
    char* cuisine;
    char* food;
    int rating;
} FoodRating;

typedef struct {
    char* name;
    int rating;
} Rating;

typedef struct {
    char* cuisine;
    Rating** ratings;
    int size;
    int capacity;
} CuisineRating;

typedef struct {
    CuisineRating** cuisines;
    int size;
    int capacity;
} FoodRatingSystem;

FoodRatingSystem* foodRatingsCreate(char** foods, char** cuisines, int* ratings, int foodsSize) {
    FoodRatingSystem* system = (FoodRatingSystem*)malloc(sizeof(FoodRatingSystem));
    system->size = 0;
    system->capacity = 10;
    system->cuisines = (CuisineRating**)malloc(system->capacity * sizeof(CuisineRating*));

    for (int i = 0; i < foodsSize; i++) {
        char* food = foods[i];
        char* cuisine = cuisines[i];
        int rating = ratings[i];

        int found = 0;
        for (int j = 0; j < system->size; j++) {
            if (strcmp(system->cuisines[j]->cuisine, cuisine) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            if (system->size >= system->capacity) {
                system->capacity *= 2;
                system->cuisines = (CuisineRating**)realloc(system->cuisines, system->capacity * sizeof(CuisineRating*));
            }
            CuisineRating* cr = (CuisineRating*)malloc(sizeof(CuisineRating));
            cr->cuisine = strdup(cuisine);
            cr->ratings = (Rating**)malloc(10 * sizeof(Rating*));
            cr->size = 0;
            cr->capacity = 10;
            system->cuisines[system->size++] = cr;
        }

        for (int j = 0; j < system->size; j++) {
            if (strcmp(system->cuisines[j]->cuisine, cuisine) == 0) {
                CuisineRating* cr = system->cuisines[j];
                if (cr->size >= cr->capacity) {
                    cr->capacity *= 2;
                    cr->ratings = (Rating**)realloc(cr->ratings, cr->capacity * sizeof(Rating*));
                }
                Rating* r = (Rating*)malloc(sizeof(Rating));
                r->name = strdup(food);
                r->rating = rating;
                cr->ratings[cr->size++] = r;
                break;
            }
        }
    }

    return system;
}

void foodRatingsChangeRating(FoodRatingSystem* obj, char* food, int newRating) {
    for (int i = 0; i < obj->size; i++) {
        CuisineRating* cr = obj->cuisines[i];
        for (int j = 0; j < cr->size; j++) {
            if (strcmp(cr->ratings[j]->name, food) == 0) {
                cr->ratings[j]->rating = newRating;
                break;
            }
        }
    }
}

char* foodRatingsHighestRated(FoodRatingSystem* obj, char* cuisine) {
    int maxRating = -1;
    char* highestFood = NULL;

    for (int i = 0; i < obj->size; i++) {
        CuisineRating* cr = obj->cuisines[i];
        if (strcmp(cr->cuisine, cuisine) == 0) {
            for (int j = 0; j < cr->size; j++) {
                if (cr->ratings[j]->rating > maxRating) {
                    maxRating = cr->ratings[j]->rating;
                    highestFood = strdup(cr->ratings[j]->name);
                } else if (cr->ratings[j]->rating == maxRating) {
                    if (strcmp(cr->ratings[j]->name, highestFood) < 0) {
                        free(highestFood);
                        highestFood = strdup(cr->ratings[j]->name);
                    }
                }
            }
            break;
        }
    }

    return highestFood;
}

void foodRatingsFree(FoodRatingSystem* obj) {
    for (int i = 0; i < obj->size; i++) {
        CuisineRating* cr = obj->cuisines[i];
        for (int j = 0; j < cr->size; j++) {
            free(cr->ratings[j]->name);
            free(cr->ratings[j]);
        }
        free(cr->ratings);
        free(cr->cuisine);
        free(cr);
    }
    free(obj->cuisines);
    free(obj);
}