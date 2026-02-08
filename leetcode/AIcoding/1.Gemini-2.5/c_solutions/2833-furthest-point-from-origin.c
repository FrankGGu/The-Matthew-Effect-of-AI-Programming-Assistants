#include <stdlib.h> // For abs

int furthestDistanceFromOrigin(char * moves) {
    int left_count = 0;
    int right_count = 0;
    int underscore_count = 0;

    int i = 0;
    while (moves[i] != '\0') {
        if (moves[i] == 'L') {
            left_count++;
        } else if (moves[i] == 'R') {
            right_count++;
        } else { // moves[i] == '_'
            underscore_count++;
        }
        i++;
    }

    int net_displacement = right_count - left_count;

    return abs(net_displacement) + underscore_count;
}