int minimumPerimeter(int neededApples) {
    long long n = (neededApples + 3) / 4;
    return 8 * (long long)sqrt(n);
}