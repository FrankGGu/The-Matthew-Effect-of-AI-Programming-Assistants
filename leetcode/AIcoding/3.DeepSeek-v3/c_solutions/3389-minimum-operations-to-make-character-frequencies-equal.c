bool canMakeEqual(int* freq) {
    int minFreq = INT_MAX;
    int maxFreq = 0;
    int nonZeroCount = 0;

    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            nonZeroCount++;
            if (freq[i] < minFreq) minFreq = freq[i];
            if (freq[i] > maxFreq) maxFreq = freq[i];
        }
    }

    if (minFreq == maxFreq) return true;
    if (maxFreq - minFreq > 1) return false;

    int minCount = 0;
    int maxCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] == minFreq) minCount++;
        else if (freq[i] == maxFreq) maxCount++;
    }

    return (maxCount == 1 && minFreq + 1 == maxFreq) || (minCount == 1 && minFreq == 1);
}

int minOperations(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    if (canMakeEqual(freq)) return 0;

    int operations = 0;
    while (true) {
        int minFreq = INT_MAX;
        int maxFreq = 0;
        int minIdx = -1;
        int maxIdx = -1;

        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                if (freq[i] < minFreq) {
                    minFreq = freq[i];
                    minIdx = i;
                }
                if (freq[i] > maxFreq) {
                    maxFreq = freq[i];
                    maxIdx = i;
                }
            }
        }

        if (minFreq == maxFreq) break;

        if (maxFreq - minFreq > 1) {
            freq[maxIdx]--;
            operations++;
        } else {
            int minCount = 0;
            int maxCount = 0;
            for (int i = 0; i < 26; i++) {
                if (freq[i] == minFreq) minCount++;
                else if (freq[i] == maxFreq) maxCount++;
            }

            if (maxCount == 1) {
                freq[maxIdx]--;
                operations++;
            } else {
                freq[minIdx]--;
                operations++;
                if (freq[minIdx] == 0) {
                    for (int i = 0; i < 26; i++) {
                        if (freq[i] > 0 && i != maxIdx) {
                            freq[i]--;
                            operations++;
                            break;
                        }
                    }
                }
            }
        }

        if (canMakeEqual(freq)) break;
    }

    return operations;
}