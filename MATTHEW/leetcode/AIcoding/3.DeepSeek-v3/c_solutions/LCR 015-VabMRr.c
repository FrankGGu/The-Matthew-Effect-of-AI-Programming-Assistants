/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findAnagrams(char * s, char * p, int* returnSize){
    int sLen = strlen(s);
    int pLen = strlen(p);

    if (sLen < pLen) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sLen * sizeof(int));
    *returnSize = 0;

    int pCount[26] = {0};
    int windowCount[26] = {0};

    for (int i = 0; i < pLen; i++) {
        pCount[p[i] - 'a']++;
    }

    for (int i = 0; i < sLen; i++) {
        windowCount[s[i] - 'a']++;

        if (i >= pLen) {
            windowCount[s[i - pLen] - 'a']--;
        }

        if (i >= pLen - 1) {
            int match = 1;
            for (int j = 0; j < 26; j++) {
                if (windowCount[j] != pCount[j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                result[(*returnSize)++] = i - pLen + 1;
            }
        }
    }

    return result;
}