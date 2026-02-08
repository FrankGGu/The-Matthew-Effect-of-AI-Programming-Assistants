#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int captureForts(int* forts, int fortsSize){
    int maxCaptured = 0;
    int lastFort = -1; 

    for (int i = 0; i < fortsSize; i++) {
        if (forts[i] != 0) {
            if (lastFort != -1 && forts[i] != forts[lastFort]) {
                int captured = 0;
                for (int j = lastFort + 1; j < i; j++) {
                    if (forts[j] == 0) {
                        captured++;
                    } else {
                        captured = 0;
                        break;
                    }
                }
                maxCaptured = (captured > maxCaptured) ? captured : maxCaptured;
            }
            lastFort = i;
        }
    }

    return maxCaptured;
}