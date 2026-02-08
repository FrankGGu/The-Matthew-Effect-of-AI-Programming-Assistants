#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BASE62_CHARS "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define BASE62_LEN 62

char *url_map[10000];
int url_count = 0;

char *encode(char *longURL) {
    url_map[url_count] = strdup(longURL);
    char *tinyURL = (char *)malloc(7 * sizeof(char));
    sprintf(tinyURL, "%d", url_count);
    url_count++;
    return tinyURL;
}

char *decode(char *shortURL) {
    int index = atoi(shortURL);
    return url_map[index];
}