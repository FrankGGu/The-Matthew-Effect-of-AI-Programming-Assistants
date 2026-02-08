int nand(int a, int b) {
    return !(a && b);
}

int solve(int a, int b) {
    int temp1 = nand(a, b);
    int temp2 = nand(a, temp1);
    int temp3 = nand(b, temp1);
    return nand(temp2, temp3);
}