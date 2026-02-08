typedef struct {
    char* food;
    char* cuisine;
    int rating;
} Food;

typedef struct {
    char* cuisine;
    double avg_rating;
} Cuisine;

typedef struct {
    Food** foods;
    int food_count;
    Cuisine** cuisines;
    int cuisine_count;
} FoodRatingSystem;

FoodRatingSystem* foodRatingSystemCreate() {
    FoodRatingSystem* system = (FoodRatingSystem*)malloc(sizeof(FoodRatingSystem));
    system->foods = (Food**)malloc(1000 * sizeof(Food*));
    system->food_count = 0;
    system->cuisines = (Cuisine**)malloc(100 * sizeof(Cuisine*));
    system->cuisine_count = 0;
    return system;
}

void foodRatingSystemAddFood(FoodRatingSystem* obj, char* food, char* cuisine, int rating) {
    Food* new_food = (Food*)malloc(sizeof(Food));
    new_food->food = food;
    new_food->cuisine = cuisine;
    new_food->rating = rating;
    obj->foods[obj->food_count++] = new_food;

    for (int i = 0; i < obj->cuisine_count; i++) {
        if (strcmp(obj->cuisines[i]->cuisine, cuisine) == 0) {
            obj->cuisines[i]->avg_rating = (obj->cuisines[i]->avg_rating * (obj->cuisines[i]->avg_rating_count) + rating) / (obj->cuisines[i]->avg_rating_count + 1);
            obj->cuisines[i]->avg_rating_count++;
            return;
        }
    }

    Cuisine* new_cuisine = (Cuisine*)malloc(sizeof(Cuisine));
    new_cuisine->cuisine = cuisine;
    new_cuisine->avg_rating = rating;
    new_cuisine->avg_rating_count = 1;
    obj->cuisines[obj->cuisine_count++] = new_cuisine;
}

void foodRatingSystemChangeRating(FoodRatingSystem* obj, char* food, int newRating) {
    for (int i = 0; i < obj->food_count; i++) {
        if (strcmp(obj->foods[i]->food, food) == 0) {
            char* cuisine = obj->foods[i]->cuisine;
            int oldRating = obj->foods[i]->rating;
            obj->foods[i]->rating = newRating;

            for (int j = 0; j < obj->cuisine_count; j++) {
                if (strcmp(obj->cuisines[j]->cuisine, cuisine) == 0) {
                    obj->cuisines[j]->avg_rating = (obj->cuisines[j]->avg_rating * obj->cuisines[j]->avg_rating_count - oldRating + newRating) / obj->cuisines[j]->avg_rating_count;
                    return;
                }
            }
        }
    }
}

char* foodRatingSystemHighestRated(FoodRatingSystem* obj, char* cuisine) {
    double highest_rating = -1;
    char* highest_food = NULL;

    for (int i = 0; i < obj->food_count; i++) {
        if (strcmp(obj->foods[i]->cuisine, cuisine) == 0) {
            if (obj->foods[i]->rating > highest_rating) {
                highest_rating = obj->foods[i]->rating;
                highest_food = obj->foods[i]->food;
            }
        }
    }

    return highest_food;
}

void foodRatingSystemFree(FoodRatingSystem* obj) {
    for (int i = 0; i < obj->food_count; i++) {
        free(obj->foods[i]);
    }
    free(obj->foods);
    for (int i = 0; i < obj->cuisine_count; i++) {
        free(obj->cuisines[i]);
    }
    free(obj->cuisines);
    free(obj);
}