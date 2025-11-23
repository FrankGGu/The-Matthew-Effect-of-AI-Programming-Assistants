char* dynamicPassword(char* password, int target) {
    int len = strlen(password);
    char* result = (char*)malloc(len + 1);
    strcpy(result, password + target);
    strncat(result, password, target);
    result[len] = '\0';
    return result;
}