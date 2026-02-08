#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int cooldown;
} Skill;

typedef struct {
    char* name;
    int count;
} SkillCount;

int compare(const void* a, const void* b) {
    SkillCount* x = (SkillCount*)a;
    SkillCount* y = (SkillCount*)b;
    return strcmp(x->name, y->name);
}

char** skillBreakdown(char** skills, int skillsSize, int* returnSize) {
    Skill* skillList = (Skill*)malloc(skillsSize * sizeof(Skill));
    for (int i = 0; i < skillsSize; i++) {
        char* skill = skills[i];
        char* token = strtok(skill, " ");
        skillList[i].name = strdup(token);
        token = strtok(NULL, " ");
        skillList[i].cooldown = atoi(token);
    }

    SkillCount* counts = (SkillCount*)malloc(skillsSize * sizeof(SkillCount));
    int count = 0;
    for (int i = 0; i < skillsSize; i++) {
        int found = 0;
        for (int j = 0; j < count; j++) {
            if (strcmp(counts[j].name, skillList[i].name) == 0) {
                counts[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            counts[count].name = strdup(skillList[i].name);
            counts[count].count = 1;
            count++;
        }
    }

    qsort(counts, count, sizeof(SkillCount), compare);

    char** result = (char**)malloc(count * sizeof(char*));
    for (int i = 0; i < count; i++) {
        result[i] = (char*)malloc(20 * sizeof(char));
        sprintf(result[i], "%s %d", counts[i].name, counts[i].count);
    }

    *returnSize = count;
    for (int i = 0; i < skillsSize; i++) {
        free(skillList[i].name);
    }
    for (int i = 0; i < count; i++) {
        free(counts[i].name);
    }
    free(skillList);
    free(counts);
    return result;
}