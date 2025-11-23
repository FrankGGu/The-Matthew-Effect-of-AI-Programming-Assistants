bool halvesAreAlike(char * s){
    int len = strlen(s);
    int count1 = 0, count2 = 0;
    for (int i = 0; i < len / 2; i++) {
        char c1 = tolower(s[i]);
        char c2 = tolower(s[len - 1 - i]);
        if (c1 == 'a' || c1 == 'e' || c1 == 'i' || c1 == 'o' || c1 == 'u') count1++;
        if (c2 == 'a' || c2 == 'e' || c2 == 'i' || c2 == 'o' || c2 == 'u') count2++;
    }
    return count1 == count2;
}