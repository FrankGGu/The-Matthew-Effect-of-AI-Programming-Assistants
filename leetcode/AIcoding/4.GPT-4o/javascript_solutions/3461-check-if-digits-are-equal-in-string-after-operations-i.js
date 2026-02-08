function digitCount(num) {
    const count = new Array(10).fill(0);
    for (let char of num) {
        count[char]++;
    }
    for (let i = 0; i < num.length; i++) {
        if (count[i] !== parseInt(num[i])) {
            return false;
        }
    }
    return true;
}