#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* smallestSufficientTeam(char ** req_skills, int req_skillsSize, char *** people, int peopleSize, int* peopleColSize, int* returnSize){
    int skills_map[req_skillsSize];
    for(int i=0; i<req_skillsSize; i++){
        skills_map[i] = i;
    }

    int dp[1 << req_skillsSize];
    int dp_size[1 << req_skillsSize];
    int** dp_team = (int**)malloc((1 << req_skillsSize) * sizeof(int*));

    for(int i=0; i<(1 << req_skillsSize); i++){
        dp[i] = -1;
        dp_size[i] = 0;
        dp_team[i] = NULL;
    }

    dp[0] = 0;

    for(int i=0; i<peopleSize; i++){
        int mask = 0;
        for(int j=0; j<peopleColSize[i]; j++){
            for(int k=0; k<req_skillsSize; k++){
                if(strcmp(people[i][j], req_skills[k]) == 0){
                    mask |= (1 << k);
                    break;
                }
            }
        }

        for(int j=0; j<(1 << req_skillsSize); j++){
            if(dp[j] != -1){
                int new_mask = j | mask;
                if(dp[new_mask] == -1 || dp_size[new_mask] > dp_size[j] + 1){
                    dp[new_mask] = 1;
                    dp_size[new_mask] = dp_size[j] + 1;
                    dp_team[new_mask] = (int*)malloc(dp_size[new_mask] * sizeof(int));
                    memcpy(dp_team[new_mask], dp_team[j], dp_size[j] * sizeof(int));
                    dp_team[new_mask][dp_size[new_mask] - 1] = i;
                }
            }
        }
    }

    *returnSize = dp_size[(1 << req_skillsSize) - 1];
    int* result = (int*)malloc(*returnSize * sizeof(int));
    memcpy(result, dp_team[(1 << req_skillsSize) - 1], *returnSize * sizeof(int));

    for(int i=0; i<(1 << req_skillsSize); i++){
        if(dp_team[i] != NULL){
            free(dp_team[i]);
        }
    }
    free(dp_team);

    return result;
}