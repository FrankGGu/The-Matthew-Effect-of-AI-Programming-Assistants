int distributeCandies(int candies, int num_children) {
    int rounds = 0;
    while (candies > 0) {
        rounds++;
        for (int i = 0; i < num_children; i++) {
            if (candies >= rounds) {
                candies -= rounds;
            } else {
                return i;
            }
        }
    }
    return num_children;
}