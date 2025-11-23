char * categorizeBox(int length, int width, int height, int mass) {
    int bulky = 0;
    int heavy = 0;

    long long volume = (long long)length * width * height;

    if (length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000) {
        bulky = 1;
    }

    if (mass >= 100) {
        heavy = 1;
    }

    if (bulky && heavy) {
        return "Both";
    } else if (!bulky && !heavy) {
        return "Neither";
    } else if (bulky && !heavy) {
        return "Bulky";
    } else {
        return "Heavy";
    }
}