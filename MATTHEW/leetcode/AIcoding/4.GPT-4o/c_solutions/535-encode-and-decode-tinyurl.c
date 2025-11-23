#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BASE 100000

typedef struct {
    char **url_map;
    int id;
} Codec;

Codec* codecCreate() {
    Codec *codec = (Codec *)malloc(sizeof(Codec));
    codec->url_map = (char **)malloc(BASE * sizeof(char *));
    codec->id = 0;
    return codec;
}

char* codecEncode(Codec* codec, char* longUrl) {
    int id = codec->id++;
    char *shortUrl = (char *)malloc(20 * sizeof(char));
    sprintf(shortUrl, "http://tinyurl.com/%d", id);
    codec->url_map[id] = strdup(longUrl);
    return shortUrl;
}

char* codecDecode(Codec* codec, char* shortUrl) {
    int id = atoi(shortUrl + 19);
    return codec->url_map[id];
}

void codecFree(Codec* codec) {
    for (int i = 0; i < codec->id; i++) {
        free(codec->url_map[i]);
    }
    free(codec->url_map);
    free(codec);
}