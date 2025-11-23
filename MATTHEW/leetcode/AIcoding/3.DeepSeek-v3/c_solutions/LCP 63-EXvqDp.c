/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* marbleGame(int* marbles, int marblesSize, int* returnSize) {
    int left = 0, right = marblesSize - 1;
    int alice = 0, bob = 0;
    int turn = 0; // 0 for Alice, 1 for Bob

    while (left <= right) {
        if (marbles[left] >= marbles[right]) {
            if (turn == 0) {
                alice += marbles[left];
            } else {
                bob += marbles[left];
            }
            left++;
        } else {
            if (turn == 0) {
                alice += marbles[right];
            } else {
                bob += marbles[right];
            }
            right--;
        }
        turn = 1 - turn;
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = alice;
    result[1] = bob;
    return result;
}