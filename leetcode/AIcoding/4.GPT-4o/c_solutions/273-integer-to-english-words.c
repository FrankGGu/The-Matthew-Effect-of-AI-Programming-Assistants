char* numberToWords(int num) {
    if (num == 0) return "Zero";

    const char *thousands[] = {"", "Thousand", "Million", "Billion"};
    const char *belowTwenty[] = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", 
                                  "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", 
                                  "Eighteen", "Nineteen"};
    const char *tens[] = {"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};

    char *result = (char *)malloc(1000);
    result[0] = '\0';

    for (int i = 0; num > 0; i++) {
        int part = num % 1000;
        if (part) {
            char buffer[100];
            snprintf(buffer, sizeof(buffer), "%s%s %s", (part >= 100 ? belowTwenty[part / 100] : ""),
                     (part % 100 >= 20 ? tens[(part % 100) / 10] : belowTwenty[part % 100]),
                     thousands[i]);
            strcat(result, buffer);
        }
        num /= 1000;
    }

    // Removing leading spaces
    char *start = result;
    while (*start == ' ') start++;

    // Reversing the result
    char *end = result + strlen(result) - 1;
    char *finalResult = (char *)malloc(1000);
    char *frPtr = finalResult;

    while (end >= start) {
        *frPtr++ = *end--;
    }
    *frPtr = '\0';

    free(result);
    return finalResult;
}