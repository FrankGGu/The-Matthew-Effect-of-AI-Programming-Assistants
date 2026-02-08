static int get_match_count(char* s1, char* s2);

void findSecretWord(char** wordlist, int wordlistSize, struct Master* master) {
    int active_indices[wordlistSize];
    int current_active_size = wordlistSize;

    for (int i = 0; i < wordlistSize; i++) {
        active_indices[i] = i;
    }

    for (int i = 0; i < 10; i++) {
        if (current_active_size == 0) {
            return;
        }

        char* current_guess_word = wordlist[active_indices[0]];

        int matches = master->guess(current_guess_word);

        if (matches == 6) {
            return;
        }

        int new_active_size = 0;
        int temp_active_indices[current_active_size];

        for (int j = 0; j < current_active_size; j++) {
            char* candidate_word = wordlist[active_indices[j]];
            if (get_match_count(current_guess_word, candidate_word) == matches) {
                temp_active_indices[new_active_size++] = active_indices[j];
            }
        }

        for (int j = 0; j < new_active_size; j++) {
            active_indices[j] = temp_active_indices[j];
        }
        current_active_size = new_active_size;
    }
}

static int get_match_count(char* s1, char* s2) {
    int count = 0;
    for (int i = 0; i < 6; i++) {
        if (s1[i] == s2[i]) {
            count++;
        }
    }
    return count;
}