#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool pyramidTransition(char* bottom, char** allowed, int allowedSize) {
    int n = strlen(bottom);
    if (n == 1) return true;

    bool next_level[27][27][27] = {false}; 
    for (int i = 0; i < allowedSize; ++i) {
        next_level[allowed[i][0] - 'A'][allowed[i][1] - 'A'][allowed[i][2] - 'A'] = true;
    }

    char next[n];
    next[n - 1] = '\0';

    bool solve(char* current) {
        int len = strlen(current);
        if (len == 1) return true;

        char next_level_str[len];
        next_level_str[len - 1] = '\0';

        bool possible = false;

        int combinations[len - 1];
        memset(combinations, 0, sizeof(combinations));

        int num_combinations = 1;
        for (int i = 0; i < len - 1; ++i) {
            int count = 0;
            for (int j = 0; j < 27; ++j) {
                if (next_level[current[i] - 'A'][current[i+1] - 'A'][j]) {
                    count++;
                }
            }
            if (count == 0) return false;
            num_combinations *= count;
        }

        if (num_combinations > 0){

            int indices[len - 1];
            memset(indices, 0, sizeof(indices));

            int num_allowed[len - 1];
            for (int i = 0; i < len - 1; ++i) {
                int count = 0;
                for (int j = 0; j < 27; ++j) {
                    if (next_level[current[i] - 'A'][current[i+1] - 'A'][j]) {
                        count++;
                    }
                }
                num_allowed[i] = count;
            }

            bool finished = false;
            while(!finished){
                for(int i = 0; i < len - 1; i++){
                    int count = 0;
                    for(int j = 0; j < 27; j++){
                        if(next_level[current[i] - 'A'][current[i+1] - 'A'][j]){
                            if(count == indices[i]){
                                next_level_str[i] = 'A' + j;
                                break;
                            }
                            count++;
                        }
                    }
                }

                if(solve(next_level_str)){
                    return true;
                }

                int index_to_increment = len - 2;
                while(index_to_increment >= 0 && indices[index_to_increment] == num_allowed[index_to_increment] - 1){
                    indices[index_to_increment] = 0;
                    index_to_increment--;
                }

                if(index_to_increment < 0){
                    finished = true;
                } else {
                    indices[index_to_increment]++;
                }
            }
        }

        return false;
    }

    return solve(bottom);
}