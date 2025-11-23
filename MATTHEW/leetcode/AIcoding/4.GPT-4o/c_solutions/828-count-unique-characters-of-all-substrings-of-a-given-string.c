int uniqueLetterString(char * s) {
    int last[128] = {0}, result = 0, n = strlen(s);
    for (int i = 0; i < n; i++) {
        int curr = last[s[i]]; 
        result += (i - curr) * (n - i); 
        last[s[i]] = i + 1; 
    }
    return result;
}