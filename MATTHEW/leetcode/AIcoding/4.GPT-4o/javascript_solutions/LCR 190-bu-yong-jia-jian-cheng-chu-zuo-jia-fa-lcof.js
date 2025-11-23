function encrypt(num1, num2) {
    const xor = num1 ^ num2;
    const and = num1 & num2;
    return xor + (and << 1);
}