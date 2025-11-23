#include <stdlib.h>
#include <string.h>

char * longestCommonPrefix(char ** strs, int strsSize){
    if (strsSize == 0) {
        return "";
    }
    if (strsSize == 1) {
        return strs[0];
    }

    char *prefix = strs[0];
    int prefix_len = strlen(prefix);

    for (int i = 1; i < strsSize; i++) {
        int j = 0;
        while (j < prefix_len && strs[i][j] != '\0' && prefix[j] == strs[i][j]) {
            j++;
        }
        prefix_len = j;
        if (prefix_len == 0) {
            return "";
        }
    }

    char *result = (char *)malloc((prefix_len + 1) * sizeof(char));
    if (result == NULL) {
        return ""; 
    }
    strncpy(result, prefix, prefix_len);
    result[prefix_len] = '\0';

    return result;
}