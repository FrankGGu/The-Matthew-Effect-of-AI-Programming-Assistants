function sortJumbled(mapping) {
    return function(arr) {
        const mapped = arr.map((num, i) => {
            let mappedNum = 0;
            let power = 1;
            while (num > 0) {
                const digit = num % 10;
                mappedNum += mapping[digit] * power;
                power *= 10;
                num = Math.floor(num / 10);
            }
            return { original: arr[i], mapped: mappedNum };
        });

        mapped.sort((a, b) => a.mapped - b.mapped);

        return mapped.map(item => item.original);
    };
}