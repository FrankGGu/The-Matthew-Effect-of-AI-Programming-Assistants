int maxNumberOfBalloons(char * text) {
    int count[26] = {0};
    for (int i = 0; text[i]; i++) {
        count[text[i] - 'a']++;
    }
    int minBalloons = count['b' - 'a'];
    minBalloons = minBalloons < count['a' - 'a'] ? minBalloons : count['a' - 'a'];
    minBalloons = minBalloons < count['l' - 'a'] / 2 ? minBalloons : count['l' - 'a'] / 2;
    minBalloons = minBalloons < count['o' - 'a'] / 2 ? minBalloons : count['o' - 'a'] / 2;
    minBalloons = minBalloons < count['n' - 'a'] ? minBalloons : count['n' - 'a'];
    return minBalloons;
}