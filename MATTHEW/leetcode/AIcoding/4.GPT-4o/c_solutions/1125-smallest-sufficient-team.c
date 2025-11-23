#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SKILLS 100
#define MAX_TEAM_SIZE 20
#define INF 21

typedef struct {
    int *skills;
    int size;
} Member;

int minTeamSize = INF;
int *bestTeam = NULL;

void dfs(Member *members, int memberCount, int *currentTeam, int currentSize, int *skillSet, int skillCount) {
    if (currentSize >= minTeamSize) return;

    int allSkills = (1 << skillCount) - 1;
    for (int i = 0; i < skillCount; i++) {
        allSkills &= ~skillSet[i];
    }
    if (allSkills == 0) {
        minTeamSize = currentSize;
        bestTeam = (int *)malloc(sizeof(int) * currentSize);
        memcpy(bestTeam, currentTeam, sizeof(int) * currentSize);
        return;
    }

    for (int i = 0; i < memberCount; i++) {
        currentTeam[currentSize] = i;
        int newSkillSet[MAX_SKILLS] = {0};
        for (int j = 0; j < currentSize + 1; j++) {
            for (int k = 0; k < members[currentTeam[j]].size; k++) {
                newSkillSet[members[currentTeam[j]].skills[k]] = 1;
            }
        }
        int newSkillBitmask = 0;
        for (int k = 0; k < skillCount; k++) {
            if (newSkillSet[k]) {
                newSkillBitmask |= (1 << k);
            }
        }
        dfs(members, memberCount, currentTeam, currentSize + 1, newSkillSet, skillCount);
    }
}

int* smallestSufficientTeam(char **req_skills, int req_skillsSize, int **people, int peopleSize, int *returnSize) {
    Member members[peopleSize];
    int skillSet[MAX_SKILLS] = {0};

    for (int i = 0; i < req_skillsSize; i++) {
        skillSet[i] = (1 << i);
    }

    for (int i = 0; i < peopleSize; i++) {
        members[i].skills = people[i];
        members[i].size = sizeof(people[i]) / sizeof(people[i][0]);
    }

    int *currentTeam = (int *)malloc(sizeof(int) * peopleSize);
    dfs(members, peopleSize, currentTeam, 0, skillSet, req_skillsSize);

    *returnSize = minTeamSize;
    return bestTeam;
}