int minGroupsForValidAssignment(int* nums, int numsSize) {
    int freq[100001] = {0};
    int maxFreq = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    int minGroups = numsSize;
    for (int groupSize = maxFreq; groupSize >= 1; groupSize--) {
        int totalGroups = 0;
        int valid = 1;

        for (int i = 0; i < 100001; i++) {
            if (freq[i] == 0) continue;

            int count = freq[i];
            int groupsForThisNum = (count + groupSize) / (groupSize + 1);
            int remainder = count - groupsForThisNum * groupSize;

            if (remainder < 0 || remainder > groupsForThisNum) {
                valid = 0;
                break;
            }

            totalGroups += groupsForThisNum;
            if (count > groupsForThisNum * groupSize) {
                totalGroups++;
            }
        }

        if (valid && totalGroups < minGroups) {
            minGroups = totalGroups;
        }
    }

    return minGroups;
}