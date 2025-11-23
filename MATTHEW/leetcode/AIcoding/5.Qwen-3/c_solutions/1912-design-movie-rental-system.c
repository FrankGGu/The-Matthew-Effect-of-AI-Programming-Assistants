#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int price;
} Movie;

typedef struct {
    int movie_id;
    int price;
    int rented;
} Rental;

typedef struct {
    int* movies;
    int size;
} MovieList;

typedef struct {
    int** prices;
    int* movie_count;
    int* rented_count;
    int** rented_movies;
    int* available_count;
    int** available_movies;
} MovieRentalSystem;

MovieRentalSystem* movieRentalSystemCreate(int n, int* entries, int* prices) {
    MovieRentalSystem* system = (MovieRentalSystem*)malloc(sizeof(MovieRentalSystem));
    system->prices = (int**)malloc(n * sizeof(int*));
    system->movie_count = (int*)malloc(n * sizeof(int));
    system->rented_count = (int*)malloc(n * sizeof(int));
    system->rented_movies = (int**)malloc(n * sizeof(int*));
    system->available_count = (int*)malloc(n * sizeof(int));
    system->available_movies = (int**)malloc(n * sizeof(int*));

    for (int i = 0; i < n; i++) {
        system->prices[i] = (int*)malloc(2 * sizeof(int));
        system->prices[i][0] = entries[i];
        system->prices[i][1] = prices[i];
        system->movie_count[i] = 0;
        system->rented_count[i] = 0;
        system->rented_movies[i] = NULL;
        system->available_count[i] = 0;
        system->available_movies[i] = NULL;
    }

    return system;
}

void movieRentalSystemAddMovie(MovieRentalSystem* obj, int movie_id, int price) {
    for (int i = 0; i < 100; i++) {
        if (obj->prices[i][0] == movie_id) {
            obj->prices[i][1] = price;
            return;
        }
    }
    for (int i = 0; i < 100; i++) {
        if (obj->prices[i][0] == 0) {
            obj->prices[i][0] = movie_id;
            obj->prices[i][1] = price;
            return;
        }
    }
}

int* movieRentalSystemSearch(MovieRentalSystem* obj, int query) {
    int* result = (int*)malloc(100 * sizeof(int));
    int index = 0;
    for (int i = 0; i < 100; i++) {
        if (obj->prices[i][0] != 0 && obj->prices[i][1] <= query) {
            result[index++] = obj->prices[i][0];
        }
    }
    return result;
}

void movieRentalSystemRent(MovieRentalSystem* obj, int movie_id, int user_id) {
    for (int i = 0; i < 100; i++) {
        if (obj->prices[i][0] == movie_id) {
            obj->movie_count[i]++;
            obj->rented_count[i]++;
            obj->rented_movies[i] = (int*)realloc(obj->rented_movies[i], obj->rented_count[i] * sizeof(int));
            obj->rented_movies[i][obj->rented_count[i] - 1] = user_id;
            break;
        }
    }
}

void movieRentalSystemDrop(MovieRentalSystem* obj, int movie_id, int user_id) {
    for (int i = 0; i < 100; i++) {
        if (obj->prices[i][0] == movie_id) {
            for (int j = 0; j < obj->rented_count[i]; j++) {
                if (obj->rented_movies[i][j] == user_id) {
                    for (int k = j; k < obj->rented_count[i] - 1; k++) {
                        obj->rented_movies[i][k] = obj->rented_movies[i][k + 1];
                    }
                    obj->rented_count[i]--;
                    obj->movie_count[i]--;
                    obj->rented_movies[i] = (int*)realloc(obj->rented_movies[i], obj->rented_count[i] * sizeof(int));
                    break;
                }
            }
            break;
        }
    }
}

int* movieRentalSystemReport(MovieRentalSystem* obj) {
    int* result = (int*)malloc(100 * sizeof(int));
    int index = 0;
    for (int i = 0; i < 100; i++) {
        if (obj->movie_count[i] > 0) {
            result[index++] = obj->prices[i][0];
        }
    }
    return result;
}

void movieRentalSystemFree(MovieRentalSystem* obj) {
    for (int i = 0; i < 100; i++) {
        free(obj->prices[i]);
        free(obj->rented_movies[i]);
        free(obj->available_movies[i]);
    }
    free(obj->prices);
    free(obj->movie_count);
    free(obj->rented_count);
    free(obj->rented_movies);
    free(obj->available_count);
    free(obj->available_movies);
    free(obj);
}