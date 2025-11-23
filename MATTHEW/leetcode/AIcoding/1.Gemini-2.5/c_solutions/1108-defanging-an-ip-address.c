#include <stdlib.h>
#include <string.h>

char * defangIPaddr(char * address){
    int len = strlen(address);
    int dot_count = 0;
    for (int i = 0; i < len; i++) {
        if (address[i] == '.') {
            dot_count++;
        }
    }

    int new_len = len + dot_count * 2;
    char *defanged_address = (char *)malloc(sizeof(char) * (new_len + 1));
    if (defanged_address == NULL) {
        return NULL;
    }

    int j = 0;
    for (int i = 0; i < len; i++) {
        if (address[i] == '.') {
            defanged_address[j++] = '[';
            defanged_address[j++] = '.';
            defanged_address[j++] = ']';
        } else {
            defanged_address[j++] = address[i];
        }
    }
    defanged_address[j] = '\0';

    return defanged_address;
}