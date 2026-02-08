#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(char * s1, char * s2){
    if (s1[0] == s2[0] && s1[1] == s2[1] && s1[2] == s2[2] && s1[3] == s2[3]) {
        return true;
    }

    char temp;

    // Swap s1[0] and s1[2]
    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp;
    if (s1[0] == s2[0] && s1[1] == s2[1] && s1[2] == s2[2] && s1[3] == s2[3]) {
        return true;
    }
    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp; // revert

    // Swap s1[1] and s1[3]
    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp;

    if (s1[0] == s2[0] && s1[1] == s2[1] && s1[2] == s2[2] && s1[3] == s2[3]) {
        return true;
    }
    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp; // revert

    // Swap s1[0] and s1[2] then s1[1] and s1[3]
    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp;

    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp;

    if (s1[0] == s2[0] && s1[1] == s2[1] && s1[2] == s2[2] && s1[3] == s2[3]) {
        return true;
    }

    return false;
}