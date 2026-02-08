#include <stdlib.h>
#include <uthash.h>

struct FreqEntry {
    int id;
    long long freq; // Frequency can be large, use long long
    UT_hash_handle hh;
};

struct CountEntry {
    long long freq_val; // The frequency value itself
    int count;          // How many IDs currently have this frequency
    UT_hash_handle hh;
};

typedef struct {
    long long *data;
    int capacity;
    int size;
} MaxHeap;

void heap_init(MaxHeap *h, int initial_capacity) {
    h->data = (long long *)malloc(sizeof(long long) * initial_capacity);
    h->capacity = initial_capacity;
    h->size = 0;
}

void heap_resize(MaxHeap *h) {
    h->capacity *= 2;
    h->data = (long long *)realloc(h->data, sizeof(long long) * h->capacity);
}

void heap_swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heap_sift_up(MaxHeap *h, int idx) {
    while (idx > 0 && h->data[idx] > h->data[(idx - 1) / 2]) {
        heap_swap(&h->data[idx], &h->data[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

void heap_sift_down(MaxHeap *h, int idx) {
    int largest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < h->size && h->data[left] > h->data[largest]) {
        largest = left;
    }
    if (right < h->size && h->data[right] > h->data[largest]) {
        largest = right;
    }

    if (largest != idx) {
        heap_swap(&h->data[idx], &h->data[largest]);
        heap_sift_down(h, largest);
    }
}

void heap_insert(MaxHeap *h, long long val) {
    if (h->size == h->capacity) {
        heap_resize(h);
    }
    h->data[h->size] = val;
    heap_sift_up(h, h->size);
    h->size++;
}

long long heap_peek_max(MaxHeap *h) {
    if (h->size == 0) return 0;
    return h->data[0];
}

long long heap_extract_max(MaxHeap *h) {
    if (h->size == 0) return 0;
    long long max_val = h->data[0];
    h->data[0] = h->data[h->size - 1];
    h->size--;
    heap_sift_down(h, 0);
    return max_val;
}

void heap_destroy(MaxHeap *h) {
    free(h->data);
    h->data = NULL;
    h->capacity = 0;
    h->size = 0;
}

int* mostFrequentIDs(int* nums, int numsSize, int* freq, int freqSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(sizeof(int) * numsSize);

    struct FreqEntry *id_to_freq_map = NULL;
    struct CountEntry *freq_to_count_map = NULL;
    MaxHeap max_heap;
    // Initial capacity for heap, ensure it's at least 1 for small numsSize
    heap_init(&max_heap, numsSize > 0 ? numsSize : 10); 

    for (int i = 0; i < numsSize; ++i) {
        int current_id = nums[i];
        long long change_delta = freq[i]; // Cast freq[i] to long long for calculation

        long long old_freq = 0;
        struct FreqEntry *entry_id;
        HASH_FIND_INT(id_to_freq_map, &current_id, entry_id);

        if (entry_id) {
            old_freq = entry_id->freq;
            if (old_freq > 0) { // If old_freq was positive, update its count
                struct CountEntry *entry_count_old;
                HASH_FIND_LONG(freq_to_count_map, &old_freq, entry_count_old);
                if (entry_count_old) { // Should always exist if old_freq > 0
                    entry_count_old->count--;
                    if (entry_count_old->count == 0) {
                        HASH_DEL(freq_to_count_map, entry_count_old);
                        free(entry_count_old);
                    }
                }
            }
        } else { // ID not found, create a new entry
            entry_id = (struct FreqEntry *)malloc(sizeof(struct FreqEntry));
            entry_id->id = current_id;
            entry_id->freq = 0; // Initialize with 0 frequency
            HASH_ADD_INT(id_to_freq_map, id, entry_id);
        }

        long long new_freq = old_freq + change_delta;
        entry_id->freq = new_freq; // Update the ID's frequency

        if (new_freq > 0) { // Only consider positive frequencies
            struct CountEntry *entry_count_new;
            HASH_FIND_LONG(freq_to_count_map, &new_freq, entry_count_new);
            if (entry_count_new) {
                entry_count_new->count++;
            } else { // New frequency value, create a new count entry
                entry_count_new = (struct CountEntry *)malloc(sizeof(struct CountEntry));
                entry_count_new->freq_val = new_freq;
                entry_count_new->count = 1;
                HASH_ADD_LONG(freq_to_count_map, freq_val, entry_count_new);
            }
            heap_insert(&max_heap, new_freq); // Add new_freq to the heap
        }

        long long current_max_freq = 0;
        // Clean up stale frequencies from the top of the heap and find the true max
        while (max_heap.size > 0) {
            long long top_freq = heap_peek_max(&max_heap);
            struct CountEntry *check_top_freq;
            HASH_FIND_LONG(freq_to_count_map, &top_freq, check_top_freq);
            if (check_top_freq && check_top_freq->count > 0) {
                // This frequency is valid and has active IDs
                current_max_freq = top_freq;
                break;
            } else {
                // This frequency is stale (count is 0 or not found), remove it from heap
                heap_extract_max(&max_heap);
            }
        }
        result[i] = (int)current_max_freq; // Store the current maximum frequency
    }

    // Clean up allocated memory for hash maps and heap
    struct FreqEntry *current_id_entry, *tmp_id_entry;
    HASH_ITER(hh, id_to_freq_map, current_id_entry, tmp_id_entry) {
        HASH_DEL(id_to_freq_map, current_id_entry);
        free(current_id_entry);
    }

    struct CountEntry *current_count_entry, *tmp_count_entry;
    HASH_ITER(hh, freq_to_count_map, current_count_entry, tmp_count_entry) {
        HASH_DEL(freq_to_count_map, current_count_entry);
        free(current_count_entry);
    }
    heap_destroy(&max_heap);

    return result;
}