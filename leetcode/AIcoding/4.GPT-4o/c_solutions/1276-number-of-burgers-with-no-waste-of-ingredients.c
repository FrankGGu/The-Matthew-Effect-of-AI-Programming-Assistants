int[] numOfBurgers(int tomatoSlices, int cheeseSlices) {
    int[] result = new int[2];
    if (tomatoSlices % 2 != 0 || cheeseSlices < 0 || tomatoSlices < 0) {
        return result;
    }
    int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
    int small = cheeseSlices - jumbo;
    if (jumbo < 0 || small < 0) {
        return result;
    }
    result[0] = jumbo;
    result[1] = small;
    return result;
}