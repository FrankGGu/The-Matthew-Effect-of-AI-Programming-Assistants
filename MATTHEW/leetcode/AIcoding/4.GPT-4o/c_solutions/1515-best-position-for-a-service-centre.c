int bestCoordinate(int** towers, int towersSize, int* towersColSize, int* returnSize) {
    int bestX = 0, bestY = 0, maxQuality = 0;
    for (int x = 0; x <= 50; x++) {
        for (int y = 0; y <= 50; y++) {
            int quality = 0;
            for (int i = 0; i < towersSize; i++) {
                int towerX = towers[i][0];
                int towerY = towers[i][1];
                int power = towers[i][2];
                double distance = sqrt((towerX - x) * (towerX - x) + (towerY - y) * (towerY - y));
                if (distance <= power) {
                    quality += (int)(power - distance);
                }
            }
            if (quality > maxQuality || (quality == maxQuality && (x < bestX || (x == bestX && y < bestY)))) {
                maxQuality = quality;
                bestX = x;
                bestY = y;
            }
        }
    }
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = bestX;
    result[1] = bestY;
    *returnSize = 2;
    return result;
}