#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset, memcpy
#include <limits.h> // For INT_MAX

#include "uthash.h"

#define MAX_SHOPS_COUNT 10001  // N up to 10^4, 1-indexed
#define MAX_MOVIES_COUNT 100001 // Movie ID up to 10^5, 1-indexed

typedef struct MovieData {
    int movie_id;
    int price;
    bool is_rented;
    int available_heap_idx; // Index in the specific movie's available_shops_heap
    int rented_heap_idx;    // Index in the global rented_movies_heap
    UT_hash_handle hh;      // Hash handle for `shops_movie_data[shop_id]`
} MovieData;

typedef struct AvailableShopItem {
    int price;
    int shop_id;
    MovieData* movie_data_ptr;
} AvailableShopItem;

typedef struct RentedMovieItem {
    int price;
    int shop_id;
    int movie_id;
    MovieData* movie_data_ptr;
} RentedMovieItem;

typedef struct Heap {
    void* items;
    int count;
    int capacity;
    size_t item_size;
    int (*compare)(const void*, const void*);
} Heap;

static int compareAvailableShopItems(const void* a, const void* b) {
    AvailableShopItem* itemA = (AvailableShopItem*)a;
    AvailableShopItem* itemB = (AvailableShopItem*)b;
    if (itemA->price != itemB->price) {
        return itemA->price - itemB->price;
    }
    return itemA->shop_id - itemB->shop_id;
}

static int compareRentedMovieItems(const void* a, const void* b) {
    RentedMovieItem* itemA = (RentedMovieItem*)a;
    RentedMovieItem* itemB = (RentedMovieItem*)b;
    if (itemA->price != itemB->price) {
        return itemA->price - itemB->price;
    }
    if (itemA->shop_id != itemB->shop_id) {
        return itemA->shop_id - itemB->shop_id;
    }
    return itemA->movie_id - itemB->movie_id;
}

void heap_init(Heap* h, int capacity, size_t item_size, int (*comp_func)(const void*, const void*)) {
    h->items = malloc(item_size * capacity);
    h->count = 0;
    h->capacity = capacity;
    h->item_size = item_size;
    h->compare = comp_func;
}

void heap_resize(Heap* h) {
    h->capacity *= 2;
    h->items = realloc(h->items, h->item_size * h->capacity);
}

void heap_swap(Heap* h, int i, int j) {
    void* item_i = (char*)h->items + i * h->item_size;
    void* item_j = (char*)h->items + j * h->item_size;

    // Update indices in MovieData pointers
    if (h->compare == compareAvailableShopItems) {
        ((AvailableShopItem*)item_i)->movie_data_ptr->available_heap_idx = j;
        ((AvailableShopItem*)item_j)->movie_data_ptr->available_heap_idx = i;
    } else { // compareRentedMovieItems
        ((RentedMovieItem*)item_i)->movie_data_ptr->rented_heap_idx = j;
        ((RentedMovieItem*)item_j)->movie_data_ptr->rented_heap_idx = i;
    }

    char temp[h->item_size];
    memcpy(temp, item_i, h->item_size);
    memcpy(item_i, item_j, h->item_size);
    memcpy(item_j, temp, h->item_size);
}

void heap_sift_up(Heap* h, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && h->compare((char*)h->items + idx * h->item_size, (char*)h->items + parent * h->item_size) < 0) {
        heap_swap(h, idx, parent);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heap_sift_down(Heap* h, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int smallest = idx;

    if (left < h->count && h->compare((char*)h->items + left * h->item_size, (char*)h->items + smallest * h->item_size) < 0) {
        smallest = left;
    }
    if (right < h->count && h->compare((char*)h->items + right * h->item_size, (char*)h->items + smallest * h->item_size) < 0) {
        smallest = right;
    }

    if (smallest != idx) {
        heap_swap(h, idx, smallest);
        heap_sift_down(h, smallest);
    }
}

void heap_insert(Heap* h, void* item_ptr) {
    if (h->count == h->capacity) {
        heap_resize(h);
    }
    memcpy((char*)h->items + h->count * h->item_size, item_ptr, h->item_size);

    // Update index in MovieData
    if (h->compare == compareAvailableShopItems) {
        ((AvailableShopItem*)((char*)h->items + h->count * h->item_size))->movie_data_ptr->available_heap_idx = h->count;
    } else { // compareRentedMovieItems
        ((RentedMovieItem*)((char*)h->items + h->count * h->item_size))->movie_data_ptr->rented_heap_idx = h->count;
    }

    h->count++;
    heap_sift_up(h, h->count - 1);
}

void heap_remove_at(Heap* h, int idx) {
    if (idx < 0 || idx >= h->count) return;

    // Mark the MovieData ptr of the element being removed as no longer in heap
    if (h->compare == compareAvailableShopItems) {
        ((AvailableShopItem*)((char*)h->items + idx * h->item_size))->movie_data_ptr->available_heap_idx = -1;
    } else {
        ((RentedMovieItem*)((char*)h->items + idx * h->item_size))->movie_data_ptr->rented_heap_idx = -1;
    }

    h->count--;
    if (idx == h->count) { // If last element removed, no swap needed
        return;
    }

    heap_swap(h, idx, h->count); // Swap with last element

    // The element that was at `h->count` is now at `idx`. Sift it.
    heap_sift_up(h, idx);
    heap_sift_down(h, idx);
}

void* heap_peek(Heap* h) {
    if (h->count == 0) {
        return NULL;
    }
    return h->items; // Return pointer to the first item
}

typedef struct {
    int num_shops;
    MovieData** shops_movie_data; // Array of hash tables: shops_movie_data[shop_id] maps movie_id to MovieData*

    Heap** available_movies_heaps; // Array of heaps: available_movies_heaps[movie_id] is a min-heap of AvailableShopItem
    Heap* rented_movies_heap; // Global min-heap of RentedMovieItem
} MovieRentalSystem;

#define INITIAL_HEAP_CAPACITY 16

MovieRentalSystem* movieRentalSystemCreate(int n) {
    MovieRentalSystem* obj = (MovieRentalSystem*)malloc(sizeof(MovieRentalSystem));
    obj->num_shops = n;

    obj->shops_movie_data = (MovieData**)calloc(n + 1, sizeof(MovieData*)); // 1-indexed shops

    obj->available_movies_heaps = (Heap**)calloc(MAX_MOVIES_COUNT, sizeof(Heap*)); // 1-indexed movies

    obj->rented_movies_heap = (Heap*)malloc(sizeof(Heap));
    heap_init(obj->rented_movies_heap, INITIAL_HEAP_CAPACITY, sizeof(RentedMovieItem), compareRentedMovieItems);

    return obj;
}

void movieRentalSystemRegister(MovieRentalSystem* obj, int shop, int movie, int price) {
    MovieData* m_data;
    HASH_FIND_INT(obj->shops_movie_data[shop], &movie, m_data);

    if (m_data == NULL) { // New movie registration
        m_data = (MovieData*)malloc(sizeof(MovieData));
        m_data->movie_id = movie;
        m_data->price = price;
        m_data->is_rented = false;
        m_data->available_heap_idx = -1;
        m_data->rented_heap_idx = -1;
        HASH_ADD_INT(obj->shops_movie_data[shop], movie_id, m_data);

        // Add to available_movies_heaps
        if (obj->available_movies_heaps[movie] == NULL) {
            obj->available_movies_heaps[movie] = (Heap*)malloc(sizeof(Heap));
            heap_init(obj->available_movies_heaps[movie], INITIAL_HEAP_CAPACITY, sizeof(AvailableShopItem), compareAvailableShopItems);
        }
        AvailableShopItem item = { .price = price, .shop_id = shop, .movie_data_ptr = m_data };
        heap_insert(obj->available_movies_heaps[movie], &item);
    } else {
        // Problem implies `register` is for new entries. If an update, logic would be more complex.
        // Assuming no price changes or re-registration of existing (shop, movie) pairs.
    }
}

int* movieRentalSystemSearch(MovieRentalSystem* obj, int movie, int* retSize) {
    Heap* movie_heap = obj->available_movies_heaps[movie];
    if (movie_heap == NULL || movie_heap->count == 0) {
        *retSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * 5);
    int shops_found = 0;

    // Use a temporary list to store the top items for later re-insertion
    AvailableShopItem temp_items[5]; 

    while (shops_found < 5 && movie_heap->count > 0) {
        AvailableShopItem* current_min_ptr = (AvailableShopItem*)heap_peek(movie_heap);
        MovieData* m_data = current_min_ptr->movie_data_ptr;

        if (!m_data->is_rented) { // Check if this item is actually available
            result[shops_found] = current_min_ptr->shop_id;
            temp_items[shops_found] = *current_min_ptr; // Store a copy
            shops_found++;
        }

        // Remove the top element (valid or stale)
        heap_remove_at(movie_heap, 0);
    }

    // Re-insert the found items back into the heap
    for (int i = 0; i < shops_found; ++i) {
        heap_insert(movie_heap, &temp_items[i]);
    }

    *retSize = shops_found;
    return result;
}

void movieRentalSystemRent(MovieRentalSystem* obj, int shop, int movie) {
    MovieData* m_data;
    HASH_FIND_INT(obj->shops_movie_data[shop], &movie, m_data);

    if (m_data == NULL || m_data->is_rented) {
        return; // Already rented or not found
    }

    m_data->is_rented = true;

    // Remove from available_movies_heaps[movie]
    Heap* movie_heap = obj->available_movies_heaps[movie];
    if (movie_heap != NULL && m_data->available_heap_idx != -1) {
        heap_remove_at(movie_heap, m_data->available_heap_idx);
        m_data->available_heap_idx = -1; // Mark as not in available heap
    }

    // Add to rented_movies_heap
    RentedMovieItem rented_item = { .price = m_data->price, .shop_id = shop, .movie_id = movie, .movie_data_ptr = m_data };
    heap_insert(obj->rented_movies_heap, &rented_item);
}

void movieRentalSystemDrop(MovieRentalSystem* obj, int shop, int movie) {
    MovieData* m_data;
    HASH_FIND_INT(obj->shops_movie_data[shop], &movie, m_data);

    if (m_data == NULL || !m_data->is_rented) {
        return; // Not rented or not found
    }

    m_data->is_rented = false;

    // Remove from rented_movies_heap
    if (m_data->rented_heap_idx != -1) {
        heap_remove_at(obj->rented_movies_heap, m_data->rented_heap_idx);
        m_data->rented_heap_idx = -1; // Mark as not in rented heap
    }

    // Add to available_movies_heaps[movie]
    Heap* movie_heap = obj->available_movies_heaps[movie];
    if (movie_heap == NULL) { // Should have been created during register
        obj->available_movies_heaps[movie] = (Heap*)malloc(sizeof(Heap));
        heap_init(obj->available_movies_heaps[movie], INITIAL_HEAP_CAPACITY, sizeof(AvailableShopItem), compareAvailableShopItems);
        movie_heap = obj->available_movies_heaps[movie];
    }
    AvailableShopItem item = { .price = m_data->price, .shop_id = shop, .movie_data_ptr = m_data };
    heap_insert(movie_heap, &item);
}

int** movieRentalSystemReport(MovieRentalSystem* obj, int* retSize, int** retColSize) {
    int** result = (int**)malloc(sizeof(int*) * 5);
    *retColSize = (int*)malloc(sizeof(int) * 5);
    int count = 0;

    // Use a temporary list to store the top items for later re-insertion
    RentedMovieItem temp_items[5]; 

    while (count < 5 && obj->rented_movies_heap->count > 0) {
        RentedMovieItem* current_min_ptr = (RentedMovieItem*)heap_peek(obj->rented_movies_heap);
        MovieData* m_data = current_min_ptr->movie_data_ptr;

        if (m_data->is_rented) { // Check if this item is actually rented
            result[count] = (int*)malloc(sizeof(int) * 3);
            result[count][0] = current_min_ptr->shop_id;
            result[count][1] = current_min_ptr->movie_id;
            result[count][2] = current_min_ptr->price;
            (*retColSize)[count] = 3;

            temp_items[count] = *current_min_ptr; // Store a copy
            count++;
        }

        // Remove the top element (valid or stale)
        heap_remove_at(obj->rented_movies_heap, 0);
    }

    // Re-insert the found items back into the heap
    for (int i = 0; i < count; ++i) {
        heap_insert(obj->rented_movies_heap, &temp_items[i]);
    }

    *retSize = count;
    return result;
}

void movieRentalSystemFree(MovieRentalSystem* obj) {
    // Free shops_movie_data
    for (int i = 1; i <= obj->num_shops; ++i) {
        MovieData* current_movie, *tmp;
        HASH_ITER(hh, obj->shops_movie_data[i], current_movie, tmp) {
            HASH_DEL(obj->shops_movie_data[i], current_movie);
            free(current_movie);
        }
    }
    free(obj->shops_movie_data);

    // Free available_movies_heaps
    for (int i = 1; i < MAX_MOVIES_COUNT; ++i) {
        if (obj->available_movies_heaps[i] != NULL) {
            free(obj->available_movies_heaps[i]->items);
            free(obj->available_movies_heaps[i]);
        }
    }
    free(obj->available_movies_heaps);

    // Free rented_movies_heap
    free(obj->rented_movies_heap->items);
    free(obj->rented_movies_heap);

    free(obj);
}