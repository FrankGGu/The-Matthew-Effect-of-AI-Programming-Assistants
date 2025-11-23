int encryptionCalculate(int dataA, int dataB) {
    while (dataB != 0) {
        int carry = (unsigned int)(dataA & dataB) << 1;
        dataA = dataA ^ dataB;
        dataB = carry;
    }
    return dataA;
}