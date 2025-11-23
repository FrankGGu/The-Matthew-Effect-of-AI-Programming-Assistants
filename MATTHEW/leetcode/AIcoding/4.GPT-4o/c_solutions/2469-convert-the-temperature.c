char** convertTemperature(double celsius, int* returnSize) {
    char** result = malloc(2 * sizeof(char*));
    *returnSize = 2;
    result[0] = malloc(20 * sizeof(char));
    result[1] = malloc(20 * sizeof(char));
    sprintf(result[0], "%.5f", celsius + 273.15);
    sprintf(result[1], "%.5f", celsius * 1.80 + 32.00);
    return result;
}