bool areAlmostEqual(char* s1, char* s2) {
    int diff_count = 0;
    int first_index = -1, second_index = -1;

    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] != s2[i]) {
            diff_count++;
            if (diff_count > 2) return false;
            if (first_index == -1) {
                first_index = i;
            } else {
                second_index = i;
            }
        }
    }

    if (diff_count == 0) return true;
    if (diff_count != 2) return false;

    return s1[first_index] == s2[second_index] && s1[second_index] == s2[first_index];
}