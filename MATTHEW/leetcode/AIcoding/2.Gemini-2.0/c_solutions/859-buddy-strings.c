#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool buddyStrings(char * s, char * goal){
    int len_s = strlen(s);
    int len_goal = strlen(goal);

    if (len_s != len_goal) {
        return false;
    }

    if (len_s < 2) {
        return false;
    }

    if (strcmp(s, goal) == 0) {
        int count[26] = {0};
        for (int i = 0; i < len_s; i++) {
            count[s[i] - 'a']++;
            if (count[s[i] - 'a'] > 1) {
                return true;
            }
        }
        return false;
    }

    int first = -1;
    int second = -1;
    int diff_count = 0;

    for (int i = 0; i < len_s; i++) {
        if (s[i] != goal[i]) {
            diff_count++;
            if (diff_count > 2) {
                return false;
            }
            if (first == -1) {
                first = i;
            } else {
                second = i;
            }
        }
    }

    if (diff_count != 2) {
        return false;
    }

    return (s[first] == goal[second] && s[second] == goal[first]);
}