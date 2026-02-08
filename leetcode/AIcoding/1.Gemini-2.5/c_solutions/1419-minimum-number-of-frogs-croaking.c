#include <string.h>

int minNumberOfFrogs(char * croakOfFrogs){
    int c_count = 0;
    int r_count = 0;
    int o_count = 0;
    int a_count = 0;
    int k_count = 0;

    int active_frogs = 0;
    int max_frogs = 0;

    int len = strlen(croakOfFrogs);

    for (int i = 0; i < len; i++) {
        char ch = croakOfFrogs[i];
        if (ch == 'c') {
            c_count++;
            active_frogs++;
            if (active_frogs > max_frogs) {
                max_frogs = active_frogs;
            }
        } else if (ch == 'r') {
            r_count++;
            if (r_count > c_count) return -1;
        } else if (ch == 'o') {
            o_count++;
            if (o_count > r_count) return -1;
        } else if (ch == 'a') {
            a_count++;
            if (a_count > o_count) return -1;
        } else if (ch == 'k') {
            k_count++;
            if (k_count > a_count) return -1;
            active_frogs--;
        } else {
            return -1;
        }
    }

    if (active_frogs == 0) {
        return max_frogs;
    } else {
        return -1;
    }
}