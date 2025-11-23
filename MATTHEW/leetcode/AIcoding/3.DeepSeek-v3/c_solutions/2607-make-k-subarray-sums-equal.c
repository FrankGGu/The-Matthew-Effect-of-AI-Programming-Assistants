int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long makeSubKSumEqual(int* arr, int arrSize, int k) {
    int g = gcd(arrSize, k);
    long long res = 0;

    for (int i = 0; i < g; i++) {
        int len = arrSize / g;
        int* temp = (int*)malloc(len * sizeof(int));

        for (int j = 0; j < len; j++) {
            temp[j] = arr[(i + j * k) % arrSize];
        }

        for (int j = 0; j < len - 1; j++) {
            for (int m = 0; m < len - j - 1; m++) {
                if (temp[m] > temp[m + 1]) {
                    int swap = temp[m];
                    temp[m] = temp[m + 1];
                    temp[m + 1] = swap;
                }
            }
        }

        int median = temp[len / 2];

        for (int j = 0; j < len; j++) {
            res += abs(temp[j] - median);
        }

        free(temp);
    }

    return res;
}