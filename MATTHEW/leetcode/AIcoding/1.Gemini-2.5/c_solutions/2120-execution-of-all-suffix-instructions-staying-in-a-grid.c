#include <stdlib.h>
#include <string.h>

int* executeInstructions(int n, int* startPos, int startPosSize, char* s, int* returnSize) {
    int len_s = strlen(s);
    int* answer = (int*)malloc(len_s * sizeof(int));
    *returnSize = len_s;

    for (int i = 0; i < len_s; i++) {
        int current_r = startPos[0];
        int current_c = startPos[1];
        int count = 0;

        for (int j = i; j < len_s; j++) {
            char instruction = s[j];
            if (instruction == 'L') {
                current_c--;
            } else if (instruction == 'R') {
                current_c++;
            } else if (instruction == 'U') {
                current_r--;
            } else if (instruction == 'D') {
                current_r++;
            }

            if (current_r < 0 || current_r >= n || current_c < 0 || current_c >= n) {
                break; // Robot moved out of bounds
            }
            count++;
        }
        answer[i] = count;
    }

    return answer;
}