function generateTheString(n) {
    if (n % 2 === 0) {
        return 'a'.repeat(n - 1) + 'b';
    } else {
        return 'a'.repeat(n);
    }
}