typedef struct {
    int id;
    int score;
} Product;

int cmp(const void *a, const void *b) {
    Product *p1 = (Product *)a;
    Product *p2 = (Product *)b;
    return p2->score - p1->score;
}

int** findProductRecommendationPairs(int** products, int productsSize, int* productsColSize, int* returnSize, int** returnColumnSizes) {
    Product *productArr = (Product *)malloc(productsSize * sizeof(Product));
    for (int i = 0; i < productsSize; i++) {
        productArr[i].id = products[i][0];
        productArr[i].score = products[i][1];
    }
    qsort(productArr, productsSize, sizeof(Product), cmp);

    int maxPairs = productsSize * (productsSize - 1) / 2;
    int **result = (int **)malloc(maxPairs * sizeof(int *));
    *returnColumnSizes = (int *)malloc(maxPairs * sizeof(int));
    int count = 0;

    for (int i = 0; i < productsSize; i++) {
        for (int j = i + 1; j < productsSize; j++) {
            if (productArr[i].score != productArr[j].score) {
                result[count] = (int *)malloc(2 * sizeof(int));
                result[count][0] = productArr[i].id;
                result[count][1] = productArr[j].id;
                (*returnColumnSizes)[count] = 2;
                count++;
            }
        }
    }

    *returnSize = count;
    free(productArr);
    return result;
}