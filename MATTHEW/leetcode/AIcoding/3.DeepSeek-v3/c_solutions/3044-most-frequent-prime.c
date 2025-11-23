int isPrime(int num) {
    if (num < 2) return 0;
    if (num == 2) return 1;
    if (num % 2 == 0) return 0;
    for (int i = 3; i * i <= num; i += 2) {
        if (num % i == 0) return 0;
    }
    return 1;
}

int mostFrequentPrime(int** mat, int matSize, int* matColSize) {
    int directions[8][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}, {1,1}, {1,-1}, {-1,1}, {-1,-1}};
    int freq[10000000] = {0};
    int maxFreq = 0;
    int result = -1;

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < matColSize[i]; j++) {
            for (int d = 0; d < 8; d++) {
                int x = i, y = j;
                int num = 0;
                while (x >= 0 && x < matSize && y >= 0 && y < matColSize[i]) {
                    num = num * 10 + mat[x][y];
                    if (num > 10 && isPrime(num)) {
                        freq[num]++;
                        if (freq[num] > maxFreq || (freq[num] == maxFreq && num > result)) {
                            maxFreq = freq[num];
                            result = num;
                        }
                    }
                    x += directions[d][0];
                    y += directions[d][1];
                }
            }
        }
    }

    return result;
}