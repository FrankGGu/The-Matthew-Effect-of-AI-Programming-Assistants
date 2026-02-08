bool canFormSquare(int* matchsticks, int matchsticksSize) {
    int sum = 0;
    for (int i = 0; i < matchsticksSize; i++) {
        sum += matchsticks[i];
    }
    if (sum % 4 != 0) return false;
    int side = sum / 4;
    int sides[4] = {0};

    return backtrack(matchsticks, matchsticksSize, sides, 0, side);
}

bool backtrack(int* matchsticks, int matchsticksSize, int* sides, int index, int side) {
    if (index == matchsticksSize) {
        return sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[3] && sides[0] == side;
    }

    for (int i = 0; i < 4; i++) {
        if (sides[i] + matchsticks[index] <= side) {
            sides[i] += matchsticks[index];
            if (backtrack(matchsticks, matchsticksSize, sides, index + 1, side)) {
                return true;
            }
            sides[i] -= matchsticks[index];
        }
        if (sides[i] == 0) break;
    }

    return false;
}