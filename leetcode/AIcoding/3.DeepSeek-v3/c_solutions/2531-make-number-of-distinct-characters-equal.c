bool isItPossible(char * word1, char * word2){
    int count1[26] = {0};
    int count2[26] = {0};

    int len1 = strlen(word1);
    int len2 = strlen(word2);

    for(int i = 0; i < len1; i++) {
        count1[word1[i] - 'a']++;
    }
    for(int i = 0; i < len2; i++) {
        count2[word2[i] - 'a']++;
    }

    int distinct1 = 0, distinct2 = 0;
    for(int i = 0; i < 26; i++) {
        if(count1[i] > 0) distinct1++;
        if(count2[i] > 0) distinct2++;
    }

    for(int i = 0; i < 26; i++) {
        if(count1[i] == 0) continue;
        for(int j = 0; j < 26; j++) {
            if(count2[j] == 0) continue;

            int newDistinct1 = distinct1;
            int newDistinct2 = distinct2;

            if(i == j) {
                if(newDistinct1 == newDistinct2) return true;
                continue;
            }

            if(count1[i] == 1) newDistinct1--;
            if(count1[j] == 0) newDistinct1++;

            if(count2[j] == 1) newDistinct2--;
            if(count2[i] == 0) newDistinct2++;

            if(newDistinct1 == newDistinct2) return true;
        }
    }

    return false;
}