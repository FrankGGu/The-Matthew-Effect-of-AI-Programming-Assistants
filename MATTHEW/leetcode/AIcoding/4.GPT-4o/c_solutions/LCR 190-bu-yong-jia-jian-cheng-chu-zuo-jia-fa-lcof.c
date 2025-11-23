int encrypt(int num) {
    return (num ^ (num >> 1));
}