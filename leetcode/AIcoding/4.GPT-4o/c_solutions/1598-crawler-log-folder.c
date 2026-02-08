int minOperations(char **logs, int logsSize) {
    int operations = 0;
    for (int i = 0; i < logsSize; i++) {
        if (strcmp(logs[i], "../") == 0) {
            if (operations > 0) operations--;
        } else if (strcmp(logs[i], "./") != 0) {
            operations++;
        }
    }
    return operations;
}