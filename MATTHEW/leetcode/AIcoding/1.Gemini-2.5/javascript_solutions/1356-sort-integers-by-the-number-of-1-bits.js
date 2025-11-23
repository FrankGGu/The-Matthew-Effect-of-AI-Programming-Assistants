var sortByBits = function(arr) {
    const countSetBits = (num) => {
        let count = 0;
        let n = num;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    };

    arr.sort((a, b) => {
        const bitCountA = countSetBits(a);
        const bitCountB = countSetBits(b);

        if (bitCountA !== bitCountB) {
            return bitCountA - bitCountB;
        } else {
            return a - b;
        }
    });

    return arr;
};