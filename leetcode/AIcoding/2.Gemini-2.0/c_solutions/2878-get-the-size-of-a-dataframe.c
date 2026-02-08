#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct DataFrame {
    int rows;
    int cols;
};

void dataFrameSize(struct DataFrame df, int* size) {
    size[0] = df.rows;
    size[1] = df.cols;
}