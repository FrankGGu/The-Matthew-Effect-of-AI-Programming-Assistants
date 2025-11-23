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
        windowCount[s[i] - 'a']++;
    }

    int matches = 0;
    for (int i = 0; i < 26; i++) {
        if (pCount[i] == windowCount[i]) {
            matches++;
        }
    }

    for (int i = 0; i <= sLen - pLen; i++) {
        if (matches == 26) {
            result[(*returnSize)++] = i;
        }

        if (i == sLen - pLen) {
            break;
        }

        int left = s[i] - 'a';
        int right = s[i + pLen] - 'a';

        windowCount[left]--;
        if (windowCount[left] == pCount[left]) {
            matches++;
        } else if (windowCount[left] == pCount[left] - 1) {
            matches--;
        }

        windowCount[right]++;
        if (windowCount[right] == pCount[right]) {
            matches++;
        } else if (windowCount[right] == pCount[right] + 1) {
            matches--;
        }
    }

    return result;
}