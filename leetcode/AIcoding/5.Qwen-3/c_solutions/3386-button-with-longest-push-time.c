#include <stdio.h>
#include <stdlib.h>

int hardestButton(char* buttons, int presses) {
    int maxTime = 0;
    char hardestChar = buttons[0];
    int count = 1;

    for (int i = 1; i < presses; i++) {
        if (buttons[i] == buttons[i - 1]) {
            count++;
        } else {
            if (count > maxTime) {
                maxTime = count;
                hardestChar = buttons[i - 1];
            }
            count = 1;
        }
    }

    if (count > maxTime) {
        hardestChar = buttons[presses - 1];
    }

    return hardestChar;
}