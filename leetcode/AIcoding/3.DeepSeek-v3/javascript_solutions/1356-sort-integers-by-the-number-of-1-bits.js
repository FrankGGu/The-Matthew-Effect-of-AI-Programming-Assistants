var sortByBits = function(arr) {
    const countBits = num => {
        let count = 0;
        while (num) {
            count += num & 1;
            num = num >>> 1;
        }
        return count;
    };

    return arr.sort((a, b) => {
        const bitA = countBits(a);
        const bitB = countBits(b);
        if (bitA === bitB) {
            return a - b;
        } else {
            return bitA - bitB;
        }
    });
};