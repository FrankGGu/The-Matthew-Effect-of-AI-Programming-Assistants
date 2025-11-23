int rand10(void) {
    int num;
    while (1) {
        num = (rand7() - 1) * 7 + rand7(); // Get a number from 1 to 49
        if (num <= 40) {
            return 1 + (num - 1) % 10; // Map 1-40 to 1-10
        }
    }
}