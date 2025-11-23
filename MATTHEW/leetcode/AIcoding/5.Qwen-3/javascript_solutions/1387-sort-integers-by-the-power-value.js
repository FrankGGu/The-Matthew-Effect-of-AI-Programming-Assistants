function getKth(lo, hi, k) {
    function getPowerValue(n) {
        let count = 0;
        while (n !== 1) {
            if (n % 2 === 0) {
                n /= 2;
            } else {
                n = 3 * n + 1;
            }
            count++;
        }
        return count;
    }

    const arr = [];
    for (let i = lo; i <= hi; i++) {
        arr.push({ num: i, power: getPowerValue(i) });
    }

    arr.sort((a, b) => a.power - b.power || a.num - b.num);

    return arr[k - 1].num;
}