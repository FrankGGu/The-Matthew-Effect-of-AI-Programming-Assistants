char * getHappyString(int n, int k){
    int total = 3 * (1 << (n - 1));
    if (k > total) return "";

    char *result = (char *)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    char choices[3] = {'a', 'b', 'c'};
    int group_size = 1 << (n - 1);
    int group = (k - 1) / group_size;
    result[0] = choices[group];

    int remaining = k - group * group_size;

    for (int i = 1; i < n; i++) {
        group_size >>= 1;
        char prev = result[i - 1];

        int index = 0;
        for (int j = 0; j < 3; j++) {
            if (choices[j] != prev) {
                if (remaining > group_size) {
                    remaining -= group_size;
                    index++;
                } else {
                    result[i] = choices[j];
                    break;
                }
            }
        }
    }

    return result;
}