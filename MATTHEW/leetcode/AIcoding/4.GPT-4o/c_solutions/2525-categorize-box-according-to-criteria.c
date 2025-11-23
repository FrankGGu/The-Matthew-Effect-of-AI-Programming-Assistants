bool categorizeBox(int length, int width, int height, int mass) {
    long long volume = (long long)length * width * height;
    bool isBulky = (length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000);
    bool isHeavy = (mass >= 100);

    if (isBulky) {
        return isHeavy ? 2 : 1;
    } else {
        return isHeavy ? 3 : 0;
    }
}