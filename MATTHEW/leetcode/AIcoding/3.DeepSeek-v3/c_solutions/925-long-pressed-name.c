bool isLongPressedName(char* name, char* typed) {
    int i = 0, j = 0;
    while (name[i] && typed[j]) {
        if (name[i] == typed[j]) {
            i++;
            j++;
        } else {
            if (j > 0 && typed[j] == typed[j - 1]) {
                j++;
            } else {
                return false;
            }
        }
    }
    while (typed[j] && typed[j] == typed[j - 1]) {
        j++;
    }
    return !name[i] && !typed[j];
}