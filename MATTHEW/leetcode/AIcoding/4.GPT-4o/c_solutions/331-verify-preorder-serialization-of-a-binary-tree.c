bool isValidSerialization(char * preorder) {
    int slots = 1, i = 0;
    while (preorder[i]) {
        if (preorder[i] == ',') {
            i++;
            continue;
        }
        slots--;
        if (slots < 0) return false;
        slots += (preorder[i] == '#') ? 0 : 2;
        while (preorder[i] && preorder[i] != ',') i++;
    }
    return slots == 0;
}