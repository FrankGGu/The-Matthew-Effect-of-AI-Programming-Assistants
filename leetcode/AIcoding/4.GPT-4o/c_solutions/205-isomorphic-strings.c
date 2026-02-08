#include <stdbool.h>
#include <string.h>

bool isIsomorphic(char * s, char * t) {
    int mapS[128] = {0}, mapT[128] = {0};
    for (int i = 0; s[i] && t[i]; i++) {
        if (mapS[s[i]] != mapT[t[i]]) {
            return false;
        }
        mapS[s[i]] = i + 1;
        mapT[t[i]] = i + 1;
    }
    return true;
}