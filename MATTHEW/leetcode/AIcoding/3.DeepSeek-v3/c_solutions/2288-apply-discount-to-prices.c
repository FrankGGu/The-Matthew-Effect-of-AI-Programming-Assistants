char* discountPrices(char* sentence, int discount) {
    double factor = (100.0 - discount) / 100.0;
    char* result = (char*)malloc(100000 * sizeof(char));
    result[0] = '\0';

    char* token = strtok(sentence, " ");
    int first = 1;

    while (token != NULL) {
        if (!first) {
            strcat(result, " ");
        }
        first = 0;

        if (token[0] == '$' && strlen(token) > 1) {
            int valid = 1;
            for (int i = 1; token[i] != '\0'; i++) {
                if (!isdigit(token[i])) {
                    valid = 0;
                    break;
                }
            }

            if (valid) {
                double price = 0.0;
                for (int i = 1; token[i] != '\0'; i++) {
                    price = price * 10 + (token[i] - '0');
                }

                double discounted = price * factor;
                char temp[50];
                sprintf(temp, "$%.2f", discounted);
                strcat(result, temp);
            } else {
                strcat(result, token);
            }
        } else {
            strcat(result, token);
        }

        token = strtok(NULL, " ");
    }

    return result;
}