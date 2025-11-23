var kBeauty = function(num, k) {
    const numStr = num.toString();
    let count = 0;

    for (let i = 0; i <= numStr.length - k; i++) {
        const substring = numStr.substring(i, i + k);
        const value = parseInt(substring, 10);
        if (value !== 0 && num % value === 0) {
            count++;
        }
    }

    return count;
};