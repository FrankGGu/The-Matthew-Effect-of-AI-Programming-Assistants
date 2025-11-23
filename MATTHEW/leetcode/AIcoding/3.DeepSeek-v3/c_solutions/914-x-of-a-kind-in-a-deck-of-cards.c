int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool hasGroupsSizeX(int* deck, int deckSize) {
    if (deckSize < 2) return false;

    int count[10000] = {0};
    int maxVal = 0;

    for (int i = 0; i < deckSize; i++) {
        count[deck[i]]++;
        if (deck[i] > maxVal) maxVal = deck[i];
    }

    int g = -1;
    for (int i = 0; i <= maxVal; i++) {
        if (count[i] > 0) {
            if (g == -1) {
                g = count[i];
            } else {
                g = gcd(g, count[i]);
            }
        }
    }

    return g >= 2;
}