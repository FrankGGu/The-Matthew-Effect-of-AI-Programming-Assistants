#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MAX_URLS 100000
#define SHORT_URL_PREFIX "http://tinyurl.com/"

char* longUrls[MAX_URLS];
int currentId = 0;

char* encode(char* longUrl) {
    longUrls[currentId] = strdup(longUrl);
    if (longUrls[currentId] == NULL) {
        return NULL;
    }

    char idStr[12];
    snprintf(idStr, sizeof(idStr), "%d", currentId);

    size_t prefixLen = strlen(SHORT_URL_PREFIX);
    size_t idStrLen = strlen(idStr);
    char* shortUrl = (char*)malloc(prefixLen + idStrLen + 1);
    if (shortUrl == NULL) {
        free(longUrls[currentId]);
        return NULL;
    }

    strcpy(shortUrl, SHORT_URL_PREFIX);
    strcat(shortUrl, idStr);

    currentId++;

    return shortUrl;
}

char* decode(char* shortUrl) {
    char* idStr = shortUrl + strlen(SHORT_URL_PREFIX);
    int id = atoi(idStr);

    return longUrls[id];
}