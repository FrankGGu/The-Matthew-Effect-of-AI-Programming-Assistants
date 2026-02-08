char* validIPAddress(char *IP) {
    int len = strlen(IP);
    int dotCount = 0, colonCount = 0, i = 0;

    if (len < 7 || len > 39) return "Neither";

    if (strchr(IP, '.') != NULL) {
        char *token = strtok(IP, ".");
        while (token) {
            dotCount++;
            if (strlen(token) == 0 || strlen(token) > 3) return "Neither";
            if (token[0] == '0' && strlen(token) > 1) return "Neither";
            int num = atoi(token);
            if (num < 0 || num > 255) return "Neither";
            token = strtok(NULL, ".");
        }
        return dotCount == 4 ? "IPv4" : "Neither";
    } else if (strchr(IP, ':') != NULL) {
        char *token = strtok(IP, ":");
        while (token) {
            colonCount++;
            if (strlen(token) == 0 || strlen(token) > 4) return "Neither";
            for (i = 0; i < strlen(token); i++) {
                if (!((token[i] >= '0' && token[i] <= '9') || 
                      (token[i] >= 'a' && token[i] <= 'f') || 
                      (token[i] >= 'A' && token[i] <= 'F'))) ) {
                    return "Neither";
                }
            }
            token = strtok(NULL, ":");
        }
        return colonCount == 8 ? "IPv6" : "Neither";
    }
    return "Neither";
}