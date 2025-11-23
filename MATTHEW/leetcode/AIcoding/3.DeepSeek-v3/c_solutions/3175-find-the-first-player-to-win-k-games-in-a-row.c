typedef struct {
    int skill;
    int index;
} Player;

int findWinningPlayer(int* skills, int skillsSize, int k) {
    if (k >= skillsSize - 1) {
        int maxSkill = skills[0];
        int maxIndex = 0;
        for (int i = 1; i < skillsSize; i++) {
            if (skills[i] > maxSkill) {
                maxSkill = skills[i];
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    Player* queue = (Player*)malloc(skillsSize * sizeof(Player));
    int front = 0, rear = 0;

    for (int i = 0; i < skillsSize; i++) {
        queue[rear].skill = skills[i];
        queue[rear].index = i;
        rear++;
    }

    int currentWinner = queue[front].index;
    int currentSkill = queue[front].skill;
    int winCount = 0;
    front++;

    while (winCount < k) {
        if (front >= rear) {
            front = 0;
        }

        if (currentSkill > queue[front].skill) {
            winCount++;
            rear++;
            queue[rear - 1].skill = queue[front].skill;
            queue[rear - 1].index = queue[front].index;
            front++;
        } else {
            winCount = 1;
            rear++;
            queue[rear - 1].skill = currentSkill;
            queue[rear - 1].index = currentWinner;
            currentWinner = queue[front].index;
            currentSkill = queue[front].skill;
            front++;
        }
    }

    free(queue);
    return currentWinner;
}