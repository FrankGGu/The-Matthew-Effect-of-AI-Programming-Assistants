typedef struct {
    int* arr;
    int size;
} Combination;

Combination* combine(int n, int k, int* returnSize) {
    Combination* result = (Combination*)malloc(sizeof(Combination));
    result->arr = (int*)malloc(sizeof(int) * 10000); // Adjust size as needed
    result->size = 0;

    int* combination = (int*)malloc(sizeof(int) * k);
    void backtrack(int start, int index) {
        if (index == k) {
            result->arr[result->size++] = (int)malloc(sizeof(int) * k);
            memcpy(result->arr[result->size - 1], combination, sizeof(int) * k);
            return;
        }
        for (int i = start; i <= n; ++i) {
            combination[index] = i;
            backtrack(i + 1, index + 1);
        }
    }

    backtrack(1, 0);
    *returnSize = result->size;
    return result;
}