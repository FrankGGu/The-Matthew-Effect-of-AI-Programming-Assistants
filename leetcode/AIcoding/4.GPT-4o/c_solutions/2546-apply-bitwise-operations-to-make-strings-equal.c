bool canBeEqual(char *target, char *arr) {
    int count[26] = {0};
    for (int i = 0; target[i]; i++) {
        count[target[i] - 'a']++;
    }
    for (int i = 0; arr[i]; i++) {
        count[arr[i] - 'a']--;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) return false;
    }
    return true;
}