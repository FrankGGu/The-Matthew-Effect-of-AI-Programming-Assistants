#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConstruct(char * ransomNote, char * magazine){
    int ransomLen = strlen(ransomNote);
    int magazineLen = strlen(magazine);

    if (ransomLen > magazineLen) {
        return false;
    }

    int charCounts[26] = {0};

    for (int i = 0; i < magazineLen; i++) {
        charCounts[magazine[i] - 'a']++;
    }

    for (int i = 0; i < ransomLen; i++) {
        if (charCounts[ransomNote[i] - 'a'] > 0) {
            charCounts[ransomNote[i] - 'a']--;
        } else {
            return false;
        }
    }

    return true;
}