int magicalString(int n) {
    if (n == 0) return 0;
    if (n <= 3) return 1;

    int* arr = (int*)malloc((n + 1) * sizeof(int));
    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 2;

    int head = 2;
    int tail = 3;
    int num = 1;
    int result = 1;

    while (tail < n) {
        for (int i = 0; i < arr[head]; i++) {
            arr[tail] = num;
            if (num == 1 && tail < n) result++;
            tail++;
        }
        num = num ^ 3;
        head++;
    }

    free(arr);
    return result;
}