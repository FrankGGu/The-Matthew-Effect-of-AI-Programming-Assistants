int flowerGame(int* flowers, int flowersSize) {
    int alice = 0, bob = 0;
    for (int i = 0; i < flowersSize; i++) {
        if (i % 2 == 0) {
            alice += flowers[i];
        } else {
            bob += flowers[i];
        }
    }
    return alice > bob ? 1 : (bob > alice ? -1 : 0);
}