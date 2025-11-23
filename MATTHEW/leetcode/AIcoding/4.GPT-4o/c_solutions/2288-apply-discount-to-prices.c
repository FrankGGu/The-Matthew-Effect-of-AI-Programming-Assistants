char * discountPrices(char * sentence, int discount) {
    char *result = malloc(strlen(sentence) + 1);
    char *ptr = result;
    char *word = strtok(sentence, " ");
    while (word) {
        if (word[0] == '$') {
            double price = atof(word + 1);
            price -= price * discount / 100.0;
            ptr += sprintf(ptr, "$%.2f ", price);
        } else {
            ptr += sprintf(ptr, "%s ", word);
        }
        word = strtok(NULL, " ");
    }
    if (ptr != result) ptr--; 
    *ptr = '\0';
    return result;
}