int maximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
    int sum = 0;

    int pickedOnes = (k < numOnes) ? k : numOnes;
    sum += pickedOnes;
    k -= pickedOnes;

    if (k > 0) {
        int pickedZeros = (k < numZeros) ? k : numZeros;
        k -= pickedZeros;
    }

    if (k > 0) {
        int pickedNegOnes = (k < numNegOnes) ? k : numNegOnes;
        sum += pickedNegOnes * (-1);
        k -= pickedNegOnes;
    }

    return sum;
}