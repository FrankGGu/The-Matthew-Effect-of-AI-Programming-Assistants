char ** splitMessage(char * message, int limit, int* returnSize) {
    int len = strlen(message);
    int count = 0, totalLength = 0;
    char **result = (char **)malloc(sizeof(char *) * 1000);

    for (int i = 1; totalLength < len; i++) {
        char buffer[50];
        int msgLen = snprintf(buffer, sizeof(buffer), "%d/%d ", i, count + 1);
        if (totalLength + msgLen > limit) {
            break;
        }
        totalLength += msgLen;
        result[count] = (char *)malloc(sizeof(char) * (limit - totalLength + len + 1));
        snprintf(result[count], limit - totalLength + len + 1, "%s%s", buffer, message + totalLength);
        totalLength += strlen(result[count]);
        count++;
    }

    *returnSize = count;
    return result;
}