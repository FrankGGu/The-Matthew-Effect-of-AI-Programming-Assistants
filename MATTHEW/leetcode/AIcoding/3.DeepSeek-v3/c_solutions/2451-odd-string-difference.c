/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char * oddString(char ** words, int wordsSize){
    int n = strlen(words[0]);
    int* diff0 = (int*)malloc((n-1) * sizeof(int));
    int* diff1 = (int*)malloc((n-1) * sizeof(int));
    int* diff2 = (int*)malloc((n-1) * sizeof(int));

    for(int i = 0; i < n-1; i++) {
        diff0[i] = words[0][i+1] - words[0][i];
        diff1[i] = words[1][i+1] - words[1][i];
        diff2[i] = words[2][i+1] - words[2][i];
    }

    int match01 = 1;
    for(int i = 0; i < n-1; i++) {
        if(diff0[i] != diff1[i]) {
            match01 = 0;
            break;
        }
    }

    if(match01) {
        for(int i = 2; i < wordsSize; i++) {
            for(int j = 0; j < n-1; j++) {
                if(words[i][j+1] - words[i][j] != diff0[j]) {
                    return words[i];
                }
            }
        }
    } else {
        int match02 = 1;
        for(int i = 0; i < n-1; i++) {
            if(diff0[i] != diff2[i]) {
                match02 = 0;
                break;
            }
        }
        if(match02) {
            return words[1];
        } else {
            return words[0];
        }
    }

    free(diff0);
    free(diff1);
    free(diff2);

    return words[0];
}