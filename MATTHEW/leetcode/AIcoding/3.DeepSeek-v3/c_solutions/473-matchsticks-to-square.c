int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

bool dfs(int* matchsticks, int matchsticksSize, int* sides, int index, int target) {
    if (index == matchsticksSize) {
        return sides[0] == target && sides[1] == target && sides[2] == target;
    }

    for (int i = 0; i < 4; i++) {
        if (sides[i] + matchsticks[index] > target) continue;

        int j = i - 1;
        while (j >= 0) {
            if (sides[j] == sides[i]) break;
            j--;
        }
        if (j != -1) continue;

        sides[i] += matchsticks[index];
        if (dfs(matchsticks, matchsticksSize, sides, index + 1, target)) {
            return true;
        }
        sides[i] -= matchsticks[index];
    }

    return false;
}

bool makesquare(int* matchsticks, int matchsticksSize) {
    if (matchsticksSize < 4) return false;

    int sum = 0;
    for (int i = 0; i < matchsticksSize; i++) {
        sum += matchsticks[i];
    }

    if (sum % 4 != 0) return false;

    int target = sum / 4;
    qsort(matchsticks, matchsticksSize, sizeof(int), cmp);

    int sides[4] = {0};
    return dfs(matchsticks, matchsticksSize, sides, 0, target);
}