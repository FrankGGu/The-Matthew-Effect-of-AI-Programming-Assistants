int numUniqueEmails(char ** emails, int emailsSize) {
    HashSet *set = hashSetCreate();
    for (int i = 0; i < emailsSize; i++) {
        char *email = emails[i];
        char local[100];
        char domain[100];
        int j = 0;
        while (email[j] != '@') {
            if (email[j] == '+') break;
            if (email[j] != '.') {
                local[strlen(local)] = email[j];
            }
            j++;
        }
        local[strlen(local)] = '\0';
        j++; // skip '@'
        strcpy(domain, email + j);
        char uniqueEmail[200];
        sprintf(uniqueEmail, "%s@%s", local, domain);
        hashSetAdd(set, uniqueEmail);
    }
    return hashSetSize(set);
}