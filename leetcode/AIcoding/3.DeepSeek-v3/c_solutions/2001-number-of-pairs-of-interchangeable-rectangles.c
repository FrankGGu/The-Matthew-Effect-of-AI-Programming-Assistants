typedef struct {
    long key;
    int count;
} HashMap;

int cmp(const void* a, const void* b) {
    long A = *(long*)a;
    long B = *(long*)b;
    return (A > B) - (A < B);
}

long long interchangeableRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    HashMap* map = (HashMap*)malloc(rectanglesSize * sizeof(HashMap));
    int mapSize = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int w = rectangles[i][0];
        int h = rectangles[i][1];
        int gcd_val = gcd(w, h);
        long ratio = (long)(w / gcd_val) * 1000000001L + (h / gcd_val);

        int found = 0;
        for (int j = 0; j < mapSize; j++) {
            if (map[j].key == ratio) {
                map[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            map[mapSize].key = ratio;
            map[mapSize].count = 1;
            mapSize++;
        }
    }

    long long result = 0;
    for (int i = 0; i < mapSize; i++) {
        long long n = map[i].count;
        result += n * (n - 1) / 2;
    }

    free(map);
    return result;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}