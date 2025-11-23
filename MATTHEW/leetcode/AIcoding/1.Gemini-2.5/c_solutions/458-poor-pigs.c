int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
    int rounds = minutesToTest / minutesToDie;
    int base = rounds + 1;
    int pigs = 0;
    int power = 1;

    while (power < buckets) {
        power *= base;
        pigs++;
    }

    return pigs;
}