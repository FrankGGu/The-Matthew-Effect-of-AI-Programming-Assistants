#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int garbageCollection(char ** garbage, int garbageSize, int * travel, int travelSize){
    int last_m = 0, last_p = 0, last_g = 0;
    int m_count = 0, p_count = 0, g_count = 0;
    int m_travel = 0, p_travel = 0, g_travel = 0;

    for(int i = 0; i < garbageSize; i++){
        for(int j = 0; j < strlen(garbage[i]); j++){
            if(garbage[i][j] == 'M'){
                m_count++;
                last_m = i;
            } else if(garbage[i][j] == 'P'){
                p_count++;
                last_p = i;
            } else {
                g_count++;
                last_g = i;
            }
        }
    }

    for(int i = 0; i < last_m; i++){
        m_travel += travel[i];
    }
    for(int i = 0; i < last_p; i++){
        p_travel += travel[i];
    }
    for(int i = 0; i < last_g; i++){
        g_travel += travel[i];
    }

    return m_count + p_count + g_count + m_travel + p_travel + g_travel;
}