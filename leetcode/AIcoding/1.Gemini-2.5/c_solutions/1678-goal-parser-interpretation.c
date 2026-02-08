#include <stdlib.h>
#include <string.h>

char * interpret(char * command){
    int len = strlen(command);
    char *result = (char *)malloc(sizeof(char) * (len + 1));
    if (result == NULL) {
        return NULL; // Handle allocation failure
    }

    int res_idx = 0;
    int cmd_idx = 0;

    while (cmd_idx < len) {
        if (command[cmd_idx] == 'G') {
            result[res_idx++] = 'G';
            cmd_idx++;
        } else if (command[cmd_idx] == '(') {
            if (command[cmd_idx + 1] == ')') {
                result[res_idx++] = 'o';
                cmd_idx += 2;
            } else { // Must be "(al)"
                result[res_idx++] = 'a';
                result[res_idx++] = 'l';
                cmd_idx += 4;
            }
        }
    }
    result[res_idx] = '\0';
    return result;
}