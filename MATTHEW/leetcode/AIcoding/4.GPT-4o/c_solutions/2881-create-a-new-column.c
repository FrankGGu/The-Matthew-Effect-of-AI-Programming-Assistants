typedef struct {
    int* data;
    int size;
} Column;

Column* createColumn(int* arr, int arrSize) {
    Column* col = (Column*)malloc(sizeof(Column));
    col->data = (int*)malloc(arrSize * sizeof(int));
    col->size = arrSize;
    for (int i = 0; i < arrSize; i++) {
        col->data[i] = arr[i];
    }
    return col;
}