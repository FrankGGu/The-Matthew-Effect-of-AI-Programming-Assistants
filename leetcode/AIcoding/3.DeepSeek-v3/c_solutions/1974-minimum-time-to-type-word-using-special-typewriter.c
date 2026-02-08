int minTimeToType(char* word) {
    int time = 0;
    char current = 'a';

    for (int i = 0; word[i] != '\0'; i++) {
        char target = word[i];
        int diff = abs(target - current);
        int move = diff < 26 - diff ? diff : 26 - diff;
        time += move + 1;
        current = target;
    }

    return time;
}