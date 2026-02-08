char * abbreviateProduct(int left, int right) {
    long long product = 1;
    int count = 0;
    for (int i = left; i <= right; i++) {
        product *= i;
        while (product % 10 == 0) {
            product /= 10;
            count++;
        }
        while (product >= 1e10) {
            product /= 10;
        }
    }

    char *result = (char *)malloc(20 * sizeof(char));
    if (count > 0) {
        sprintf(result, "%llde%d", product, count);
    } else {
        sprintf(result, "%lld", product);
    }

    return result;
}