#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BASE 62
#define SHORT_LEN 6

const char base62_chars[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

int char_to_index(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'Z') return 10 + c - 'A';
    if (c >= 'a' && c <= 'z') return 36 + c - 'a';
    return -1;
}

char index_to_char(int i) {
    return base62_chars[i];
}

unsigned long long hash(const char* s) {
    unsigned long long hash = 0;
    while (*s) {
        hash = (hash * 1000003) ^ (unsigned long long)*s;
        s++;
    }
    return hash;
}

typedef struct {
    char short_url[SHORT_LEN + 1];
    char long_url[1024];
} URLMap;

URLMap url_map[1000000];
int map_size = 0;

char* encode(char* longUrl) {
    unsigned long long h = hash(longUrl);
    int i, j;
    for (i = 0; i < SHORT_LEN; i++) {
        url_map[map_size].short_url[i] = index_to_char(h % BASE);
        h /= BASE;
    }
    url_map[map_size].short_url[SHORT_LEN] = '\0';
    strcpy(url_map[map_size].long_url, longUrl);
    map_size++;
    return url_map[map_size - 1].short_url;
}

char* decode(char* shortUrl) {
    for (int i = 0; i < map_size; i++) {
        if (strcmp(url_map[i].short_url, shortUrl) == 0) {
            return url_map[i].long_url;
        }
    }
    return NULL;
}