function minInteger(num, k) {
    const n = num.length;
    const digits = num.split('').map(c => parseInt(c));

    for (let i = 0; i < n && k > 0; i++) {
        let minPos = i;
        for (let j = i + 1; j < n && j - i <= k; j++) {
            if (digits[j] < digits[minPos]) {
                minPos = j;
            }
        }
        if (minPos !== i) {
            const temp = digits[i];
            digits[i] = digits[minPos];
            digits[minPos] = temp;
            k -= minPos - i;
        }
    }

    return digits.join('');
}