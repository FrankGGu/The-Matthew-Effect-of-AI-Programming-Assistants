int maxHeightOfTriangle(int red, int blue) {
    int maxHeight = 0;

    for (int firstColor = 0; firstColor <= 1; firstColor++) {
        int r = red;
        int b = blue;
        int height = 0;
        int level = 1;

        while (1) {
            int needed;
            if (level % 2 == 1) {
                needed = (firstColor == 0) ? r : b;
            } else {
                needed = (firstColor == 0) ? b : r;
            }

            if (needed < level) break;

            if (level % 2 == 1) {
                if (firstColor == 0) r -= level;
                else b -= level;
            } else {
                if (firstColor == 0) b -= level;
                else r -= level;
            }

            height++;
            level++;
        }

        if (height > maxHeight) maxHeight = height;
    }

    return maxHeight;
}