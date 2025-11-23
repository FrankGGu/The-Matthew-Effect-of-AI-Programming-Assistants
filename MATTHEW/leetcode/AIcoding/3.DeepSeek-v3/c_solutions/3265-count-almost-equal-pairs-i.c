int countPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int x = nums[i], y = nums[j];
            if (x == y) {
                count++;
                continue;
            }

            int diff = 0;
            while (x > 0 || y > 0) {
                int d1 = x % 10;
                int d2 = y % 10;
                if (d1 != d2) diff++;
                if (diff > 2) break;
                x /= 10;
                y /= 10;
            }

            if (diff <= 2) count++;
        }
    }
    return count;
}