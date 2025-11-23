bool buddyStrings(char * s, char * goal){
    int len_s = strlen(s);
    int len_g = strlen(goal);

    if (len_s != len_g) return false;

    int diff_count = 0;
    int diff_pos[2];
    int freq[26] = {0};
    bool has_duplicate = false;

    for (int i = 0; i < len_s; i++) {
        if (s[i] != goal[i]) {
            if (diff_count < 2) {
                diff_pos[diff_count] = i;
            }
            diff_count++;
        }
        freq[s[i] - 'a']++;
        if (freq[s[i] - 'a'] >= 2) {
            has_duplicate = true;
        }
    }

    if (diff_count == 0) {
        return has_duplicate;
    }

    if (diff_count != 2) {
        return false;
    }

    return s[diff_pos[0]] == goal[diff_pos[1]] && s[diff_pos[1]] == goal[diff_pos[0]];
}