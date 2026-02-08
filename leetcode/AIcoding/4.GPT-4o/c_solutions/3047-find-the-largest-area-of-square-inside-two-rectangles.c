int maxArea(int left1, int right1, int left2, int right2, int height) {
    int width1 = right1 - left1;
    int width2 = right2 - left2;
    int maxWidth = fmin(width1, width2);
    return fmin(maxWidth, height) * fmin(maxWidth, height);
}