int minTimeToType(char * word) {
    int time = 0, currentPos = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        int targetPos = word[i] - 'a';
        int distance = abs(targetPos - currentPos);
        time += distance < 13 ? distance : 26 - distance;
        time += 1; // for typing the character
        currentPos = targetPos;
    }
    return time;
}