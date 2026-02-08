int maxContainers(int n, int w, int maxWeight) {
    int rows = n;
    int cols = n;
    int maxContainers = 0;

    for (int r = 1; r <= rows; r++) {
        for (int c = 1; c <= cols; c++) {
            if (r * c * w <= maxWeight) {
                if (r * c > maxContainers) {
                    maxContainers = r * c;
                }
            }
        }
    }

    return maxContainers;
}