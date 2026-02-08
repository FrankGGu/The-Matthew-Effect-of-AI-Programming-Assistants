#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MOVIES 10001
#define MAX_SHOPS 51

typedef struct {
    int movie;
    int shop;
    int price;
} Rental;

typedef struct {
    int shop;
    int movie;
    int price;
} AvailableMovie;

typedef struct {
    int shop;
    int movie;
} RentedMovie;

typedef struct {
    int movie_prices[MAX_SHOPS];
} MovieData;

typedef struct {
    MovieData movies[MAX_MOVIES];
    int movie_count;
    int shop_count;
    Rental* rented_movies;
    int rented_count;
    AvailableMovie* available_movies;
    int available_count;
} MovieRentingSystem;

MovieRentingSystem* movieRentingSystemCreate(int n, int m, int** entries, int entriesSize, int* entriesColSize) {
    MovieRentingSystem* obj = (MovieRentingSystem*)malloc(sizeof(MovieRentingSystem));
    obj->movie_count = MAX_MOVIES;
    obj->shop_count = n;
    obj->rented_movies = (Rental*)malloc(sizeof(Rental) * m * n);
    obj->rented_count = 0;
    obj->available_movies = (AvailableMovie*)malloc(sizeof(AvailableMovie) * m * n);
    obj->available_count = 0;

    for (int i = 0; i < MAX_MOVIES; i++) {
        for (int j = 0; j < MAX_SHOPS; j++) {
            obj->movies[i].movie_prices[j] = -1;
        }
    }

    for (int i = 0; i < entriesSize; i++) {
        int shop = entries[i][0];
        int movie = entries[i][1];
        int price = entries[i][2];
        obj->movies[movie].movie_prices[shop] = price;
        obj->available_movies[obj->available_count].shop = shop;
        obj->available_movies[obj->available_count].movie = movie;
        obj->available_movies[obj->available_count].price = price;
        obj->available_count++;
    }

    return obj;
}

int compareAvailableMovies(const void* a, const void* b) {
    AvailableMovie* movie1 = (AvailableMovie*)a;
    AvailableMovie* movie2 = (AvailableMovie*)b;

    if (movie1->price != movie2->price) {
        return movie1->price - movie2->price;
    } else if (movie1->shop != movie2->shop) {
        return movie1->shop - movie2->shop;
    } else {
        return movie1->movie - movie2->movie;
    }
}

int** movieRentingSystemSearch(MovieRentingSystem* obj, int movie, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * obj->shop_count);
    *returnColumnSizes = (int*)malloc(sizeof(int) * obj->shop_count);
    *returnSize = 0;

    AvailableMovie temp_movies[MAX_SHOPS];
    int temp_count = 0;

    for (int i = 0; i < obj->available_count; i++) {
        if (obj->available_movies[i].movie == movie) {
            temp_movies[temp_count].shop = obj->available_movies[i].shop;
            temp_movies[temp_count].movie = obj->available_movies[i].movie;
            temp_movies[temp_count].price = obj->available_movies[i].price;
            temp_count++;
        }
    }

    qsort(temp_movies, temp_count, sizeof(AvailableMovie), compareAvailableMovies);

    int count = (temp_count < 5) ? temp_count : 5;
    for (int i = 0; i < count; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = temp_movies[i].shop;
        result[i][1] = temp_movies[i].price;
        (*returnColumnSizes)[i] = 2;
        (*returnSize)++;
    }

    return result;
}

void movieRentingSystemRent(MovieRentingSystem* obj, int shop, int movie) {
    int price = obj->movies[movie].movie_prices[shop];
    obj->rented_movies[obj->rented_count].movie = movie;
    obj->rented_movies[obj->rented_count].shop = shop;
    obj->rented_movies[obj->rented_count].price = price;
    obj->rented_count++;

    for (int i = 0; i < obj->available_count; i++) {
        if (obj->available_movies[i].movie == movie && obj->available_movies[i].shop == shop) {
            for (int j = i; j < obj->available_count - 1; j++) {
                obj->available_movies[j] = obj->available_movies[j + 1];
            }
            obj->available_count--;
            break;
        }
    }
}

void movieRentingSystemDrop(MovieRentingSystem* obj, int shop, int movie) {
    int price = obj->movies[movie].movie_prices[shop];
    obj->available_movies[obj->available_count].shop = shop;
    obj->available_movies[obj->available_count].movie = movie;
    obj->available_movies[obj->available_count].price = price;
    obj->available_count++;

    for (int i = 0; i < obj->rented_count; i++) {
        if (obj->rented_movies[i].movie == movie && obj->rented_movies[i].shop == shop) {
            for (int j = i; j < obj->rented_count - 1; j++) {
                obj->rented_movies[j] = obj->rented_movies[j + 1];
            }
            obj->rented_count--;
            break;
        }
    }
}

int compareRentedMovies(const void* a, const void* b) {
    Rental* movie1 = (Rental*)a;
    Rental* movie2 = (Rental*)b;

    if (movie1->price != movie2->price) {
        return movie1->price - movie2->price;
    } else if (movie1->shop != movie2->shop) {
        return movie1->shop - movie2->shop;
    } else {
        return movie1->movie - movie2->movie;
    }
}

int** movieRentingSystemReport(MovieRentingSystem* obj, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * obj->rented_count);
    *returnColumnSizes = (int*)malloc(sizeof(int) * obj->rented_count);
    *returnSize = 0;

    if (obj->rented_count == 0) {
        return result;
    }

    Rental sorted_rented_movies[obj->rented_count];
    for (int i = 0; i < obj->rented_count; i++) {
        sorted_rented_movies[i] = obj->rented_movies[i];
    }

    qsort(sorted_rented_movies, obj->rented_count, sizeof(Rental), compareRentedMovies);

    int count = (obj->rented_count < 5) ? obj->rented_count : 5;
    for (int i = 0; i < count; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = sorted_rented_movies[i].shop;
        result[i][1] = sorted_rented_movies[i].movie;
        (*returnColumnSizes)[i] = 2;
        (*returnSize)++;
    }

    return result;
}

void movieRentingSystemFree(MovieRentingSystem* obj) {
    free(obj->rented_movies);
    free(obj->available_movies);