int calculateScore(int* nums, int numsSize, char* s) {
    int score = 0;
    int pos = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'R') {
            pos++;
            if (pos >= numsSize) pos = numsSize - 1;
        } else if (s[i] == 'L') {
            pos--;
            if (pos < 0) pos = 0;
        }

        score += nums[pos];

        if (nums[pos] == 0) {
            return score;
        }
    }

    return score;
}