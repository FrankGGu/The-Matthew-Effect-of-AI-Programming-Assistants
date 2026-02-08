int maxKItems(int numOnes, int numZeros, int numNegOnes) {
    int total = numOnes + numZeros;
    return numOnes >= total ? total : numOnes;
}