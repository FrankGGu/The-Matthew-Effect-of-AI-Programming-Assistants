char *decodeAtIndex(char *S, int K) {
    long long length = 0;
    char *result = NULL;

    for (int i = 0; S[i] != '\0'; i++) {
        if (S[i] >= '0' && S[i] <= '9') {
            length *= (S[i] - '0');
        } else {
            length++;
        }
    }

    for (int i = strlen(S) - 1; i >= 0; i--) {
        K %= length;
        if (K == 0 && S[i] >= 'a' && S[i] <= 'z') {
            result = (char *)malloc(2 * sizeof(char));
            result[0] = S[i];
            result[1] = '\0';
            return result;
        }

        if (S[i] >= '0' && S[i] <= '9') {
            length /= (S[i] - '0');
        } else {
            length--;
        }
    }

    return NULL;
}