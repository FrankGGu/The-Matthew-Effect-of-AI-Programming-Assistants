bool checkSpam(char *message) {
    char *spamKeywords[] = {"free", "win", "winner", "money", "prize", "urgent", "click", "buy now", "limited time", "call now"};
    for (int i = 0; i < 10; i++) {
        if (strstr(message, spamKeywords[i]) != NULL) {
            return true;
        }
    }
    return false;
}