int dividePlayers(int* skill, int skillSize) {
    int totalSkill = 0;
    for (int i = 0; i < skillSize; i++) {
        totalSkill += skill[i];
    }

    if (totalSkill % (skillSize / 2) != 0) {
        return -1;
    }

    int targetSkill = totalSkill / (skillSize / 2);
    int result = 0;
    int* skillCount = (int*)calloc(101, sizeof(int));

    for (int i = 0; i < skillSize; i++) {
        skillCount[skill[i]]++;
    }

    for (int i = 0; i < skillSize; i++) {
        if (skillCount[skill[i]] > 0) {
            skillCount[skill[i]]--;
            int complement = targetSkill - skill[i];
            if (complement < 0 || complement > 100 || skillCount[complement] <= 0) {
                free(skillCount);
                return -1;
            }
            skillCount[complement]--;
            result += skill[i] * complement;
        }
    }

    free(skillCount);
    return result / 2;
}