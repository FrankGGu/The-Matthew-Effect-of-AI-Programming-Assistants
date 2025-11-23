var findEvenNumbers = function(digits) {
    const counts = new Array(10).fill(0);
    for (const digit of digits) {
        counts[digit]++;
    }

    const result = [];
    for (let i = 100; i <= 999; i += 2) {
        const str = i.toString();
        const tempCounts = new Array(10).fill(0);
        let possible = true;
        for (const char of str) {
            const digit = parseInt(char);
            tempCounts[digit]++;
            if (tempCounts[digit] > counts[digit]) {
                possible = false;
                break;
            }
        }
        if (possible) {
            result.push(i);
        }
    }

    return result;
};