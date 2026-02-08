#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaximizedCapital(int k, int w, int* profits, int profitsSize, int* capital, int capitalSize) {
    int i, j, maxProfit;
    int* availableProjects = (int*)malloc(profitsSize * sizeof(int));
    int availableProjectsSize = 0;

    for (i = 0; i < profitsSize; i++) {
        if (capital[i] <= w) {
            availableProjects[availableProjectsSize++] = i;
        }
    }

    for (i = 0; i < k; i++) {
        if (availableProjectsSize == 0) {
            break;
        }

        maxProfit = -1;
        int projectIndex = -1;
        for (j = 0; j < availableProjectsSize; j++) {
            if (profits[availableProjects[j]] > maxProfit) {
                maxProfit = profits[availableProjects[j]];
                projectIndex = j;
            }
        }

        w += maxProfit;
        int selectedProjectIndex = availableProjects[projectIndex];

        for (j = projectIndex; j < availableProjectsSize - 1; j++) {
            availableProjects[j] = availableProjects[j + 1];
        }
        availableProjectsSize--;

        int newAvailableProjectsSize = 0;
        int* newAvailableProjects = (int*)malloc(profitsSize * sizeof(int));
        for (j = 0; j < profitsSize; j++) {
            int isAlreadyAvailable = 0;
            for(int l = 0; l < availableProjectsSize; l++){
                if(availableProjects[l] == j) {
                    isAlreadyAvailable = 1;
                    break;
                }
            }
            if (capital[j] <= w && j != selectedProjectIndex && !isAlreadyAvailable) {
                newAvailableProjects[newAvailableProjectsSize++] = j;
            }
        }

        int* temp = (int*)malloc((availableProjectsSize + newAvailableProjectsSize) * sizeof(int));
        for(int l = 0; l < availableProjectsSize; l++){
            temp[l] = availableProjects[l];
        }
        for(int l = 0; l < newAvailableProjectsSize; l++){
            temp[availableProjectsSize+l] = newAvailableProjects[l];
        }
        free(availableProjects);
        free(newAvailableProjects);
        availableProjects = temp;
        availableProjectsSize += newAvailableProjectsSize;
    }

    free(availableProjects);
    return w;
}