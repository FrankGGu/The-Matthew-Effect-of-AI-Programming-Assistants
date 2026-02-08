#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int width;
    int height;
} Rectangle;

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int interchangeableRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int count = 0;
    int* ratios = (int*)calloc(rectanglesSize, sizeof(int));

    for (int i = 0; i < rectanglesSize; i++) {
        int w = rectangles[i][0];
        int h = rectangles[i][1];
        int g = gcd(w, h);
        ratios[i] = (w / g) * 10000 + (h / g);  // Store ratio as a single number
    }

    for (int i = 0; i < rectanglesSize; i++) {
        for (int j = i + 1; j < rectanglesSize; j++) {
            if (ratios[i] == ratios[j]) {
                count++;
            }
        }
    }

    free(ratios);
    return count;
}