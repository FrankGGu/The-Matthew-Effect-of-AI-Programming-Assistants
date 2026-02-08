int maximumArea(int** dimensions, int dimensionsSize, int* dimensionsColSize) {
    int max_diagonal_squared = 0;
    int max_area = 0;

    for (int i = 0; i < dimensionsSize; i++) {
        int length = dimensions[i][0];
        int width = dimensions[i][1];

        int current_diagonal_squared = length * length + width * width;
        int current_area = length * width;

        if (current_diagonal_squared > max_diagonal_squared) {
            max_diagonal_squared = current_diagonal_squared;
            max_area = current_area;
        } else if (current_diagonal_squared == max_diagonal_squared) {
            if (current_area > max_area) {
                max_area = current_area;
            }
        }
    }

    return max_area;
}