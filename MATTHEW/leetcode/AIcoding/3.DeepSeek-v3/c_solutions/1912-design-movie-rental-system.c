#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ENTRIES 100000

typedef struct {
    int movie;
    int price;
    int shop;
    int rented;
} Entry;

typedef struct {
    Entry* entries;
    int size;
    int capacity;
} MinHeap;

typedef struct {
    Entry* entries;
    int size;
    int capacity;
} ReportHeap;

Entry g_entries[MAX_ENTRIES];
int g_entryCount = 0;

MinHeap g_movieHeaps[10001];
ReportHeap g_reportHeap;

int g_rentedCount = 0;

int comparePrice(const void* a, const void* b) {
    Entry* e1 = (Entry*)a;
    Entry* e2 = (Entry*)b;
    if (e1->price != e2->price) return e1->price - e2->price;
    if (e1->shop != e2->shop) return e1->shop - e2->shop;
    return e1->movie - e2->movie;
}

int compareReport(const void* a, const void* b) {
    Entry* e1 = (Entry*)a;
    Entry* e2 = (Entry*)b;
    if (e1->price != e2->price) return e1->price - e2->price;
    if (e1->shop != e2->shop) return e1->shop - e2->shop;
    return e1->movie - e2->movie;
}

void initHeap(MinHeap* heap) {
    heap->capacity = 10;
    heap->size = 0;
    heap->entries = malloc(heap->capacity * sizeof(Entry));
}

void initReportHeap() {
    g_reportHeap.capacity = 10;
    g_reportHeap.size = 0;
    g_reportHeap.entries = malloc(g_reportHeap.capacity * sizeof(Entry));
}

void heapPush(MinHeap* heap, Entry entry) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->entries = realloc(heap->entries, heap->capacity * sizeof(Entry));
    }
    heap->entries[heap->size] = entry;
    int i = heap->size;
    heap->size++;

    while (i > 0) {
        int parent = (i - 1) / 2;
        if (comparePrice(&heap->entries[i], &heap->entries[parent]) >= 0) break;
        Entry temp = heap->entries[i];
        heap->entries[i] = heap->entries[parent];
        heap->entries[parent] = temp;
        i = parent;
    }
}

void reportPush(Entry entry) {
    if (g_reportHeap.size == g_reportHeap.capacity) {
        g_reportHeap.capacity *= 2;
        g_reportHeap.entries = realloc(g_reportHeap.entries, g_reportHeap.capacity * sizeof(Entry));
    }
    g_reportHeap.entries[g_reportHeap.size] = entry;
    int i = g_reportHeap.size;
    g_reportHeap.size++;

    while (i > 0) {
        int parent = (i - 1) / 2;
        if (compareReport(&g_reportHeap.entries[i], &g_reportHeap.entries[parent]) >= 0) break;
        Entry temp = g_reportHeap.entries[i];
        g_reportHeap.entries[i] = g_reportHeap.entries[parent];
        g_reportHeap.entries[parent] = temp;
        i = parent;
    }
}

Entry heapPop(MinHeap* heap) {
    Entry result = heap->entries[0];
    heap->size--;
    heap->entries[0] = heap->entries[heap->size];

    int i = 0;
    while (1) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int smallest = i;

        if (left < heap->size && comparePrice(&heap->entries[left], &heap->entries[smallest]) < 0) {
            smallest = left;
        }
        if (right < heap->size && comparePrice(&heap->entries[right], &heap->entries[smallest]) < 0) {
            smallest = right;
        }
        if (smallest == i) break;

        Entry temp = heap->entries[i];
        heap->entries[i] = heap->entries[smallest];
        heap->entries[smallest] = temp;
        i = smallest;
    }

    return result;
}

Entry reportPop() {
    Entry result = g_reportHeap.entries[0];
    g_reportHeap.size--;
    g_reportHeap.entries[0] = g_reportHeap.entries[g_reportHeap.size];

    int i = 0;
    while (1) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int smallest = i;

        if (left < g_reportHeap.size && compareReport(&g_reportHeap.entries[left], &g_reportHeap.entries[smallest]) < 0) {
            smallest = left;
        }
        if (right < g_reportHeap.size && compareReport(&g_reportHeap.entries[right], &g_reportHeap.entries[smallest]) < 0) {
            smallest = right;
        }
        if (smallest == i) break;

        Entry temp = g_reportHeap.entries[i];
        g_reportHeap.entries[i] = g_reportHeap.entries[smallest];
        g_reportHeap.entries[smallest] = temp;
        i = smallest;
    }

    return result;
}

void MovieRentingSystemInit(int n, int** entries, int entriesSize, int* entriesColSize) {
    for (int i = 0; i < 10001; i++) {
        initHeap(&g_movieHeaps[i]);
    }
    initReportHeap();

    for (int i = 0; i < entriesSize; i++) {
        Entry entry;
        entry.shop = entries[i][0];
        entry.movie = entries[i][1];
        entry.price = entries[i][2];
        entry.rented = 0;

        g_entries[g_entryCount++] = entry;
        heapPush(&g_movieHeaps[entry.movie], entry);
    }
}

int* MovieRentingSystemSearch(int movie, int* retSize) {
    MinHeap tempHeap;
    initHeap(&tempHeap);

    int count = 0;
    int maxResults = 5;
    int* result = malloc(maxResults * sizeof(int));

    while (g_movieHeaps[movie].size > 0 && count < maxResults) {
        Entry entry = heapPop(&g_movieHeaps[movie]);
        if (entry.rented) continue;

        result[count++] = entry.shop;
        heapPush(&tempHeap, entry);
    }

    while (tempHeap.size > 0) {
        Entry entry = heapPop(&tempHeap);
        heapPush(&g_movieHeaps[movie], entry);
    }

    free(tempHeap.entries);
    *retSize = count;
    return result;
}

void MovieRentingSystemRent(int shop, int movie) {
    for (int i = 0; i < g_entryCount; i++) {
        if (g_entries[i].shop == shop && g_entries[i].movie == movie && !g_entries[i].rented) {
            g_entries[i].rented = 1;
            reportPush(g_entries[i]);
            g_rentedCount++;
            break;
        }
    }
}

void MovieRentingSystemDrop(int shop, int movie) {
    for (int i = 0; i < g_entryCount; i++) {
        if (g_entries[i].shop == shop && g_entries[i].movie == movie && g_entries[i].rented) {
            g_entries[i].rented = 0;
            heapPush(&g_movieHeaps[movie], g_entries[i]);
            g_rentedCount--;
            break;
        }
    }
}

int** MovieRentingSystemReport(int* retSize, int** retColSize) {
    int maxResults = 5;
    int actualResults = g_rentedCount < maxResults ? g_rentedCount : maxResults;

    int** result = malloc(actualResults * sizeof(int*));
    *retColSize = malloc(actualResults * sizeof(int));

    MinHeap tempHeap;
    initHeap(&tempHeap);

    for (int i = 0; i < actualResults; i++) {
        Entry entry = reportPop();
        result[i] = malloc(3 * sizeof(int));
        result[i][0] = entry.shop;
        result[i][1] = entry.movie;
        result[i][2] = entry.price;
        (*retColSize)[i] = 3;
        heapPush(&tempHeap, entry);
    }

    while (tempHeap.size > 0) {
        Entry entry = heapPop(&tempHeap);
        reportPush(entry);
    }

    free(tempHeap.entries);
    *retSize = actualResults