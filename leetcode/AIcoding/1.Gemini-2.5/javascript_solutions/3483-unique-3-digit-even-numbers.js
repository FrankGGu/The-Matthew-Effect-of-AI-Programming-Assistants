function findEvenNumbers(digits) {
    const counts = new Array(10).fill(0);
    for (const digit of digits) {
        counts[digit]++;
    }

    const uniqueEvenNumbers = new Set();

    for (let i = 100; i <= 998; i += 2) {
        const h = Math.floor(i / 100);
        const t = Math.floor((i % 100) / 10);
        const u = i % 10;

        const tempCounts = new Array(10).fill(0);
        tempCounts[h]++;
        tempCounts[t]++;
        tempCounts[u]++;

        let canForm = true;
        for (let d = 0; d <= 9; d++) {
            if (tempCounts[d] > counts[d]) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            uniqueEvenNumbers.add(i);
        }
    }

    const result = Array.from(uniqueEvenNumbers);
    return result;
}