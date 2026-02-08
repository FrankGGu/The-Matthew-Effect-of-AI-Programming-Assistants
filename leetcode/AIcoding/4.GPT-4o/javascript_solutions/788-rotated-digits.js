var rotatedDigits = function(N) {
    let count = 0;
    for (let i = 1; i <= N; i++) {
        let num = i.toString();
        if (/^[0-1-5-9]*$/.test(num) && /[2-5-6-9]/.test(num)) {
            count++;
        }
    }
    return count;
};