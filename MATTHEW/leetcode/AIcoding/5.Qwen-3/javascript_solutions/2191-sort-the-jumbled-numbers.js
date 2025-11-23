function sortJumbled(arr) {
    const mapped = arr.map((num, index) => {
        const digits = num.toString().split('').map(Number);
        const mappedDigits = digits.map(d => d === 0 ? 0 : d + 1);
        const mappedNum = parseInt(mappedDigits.join(''), 10) || 0;
        return { original: num, mapped: mappedNum, index: index };
    });

    mapped.sort((a, b) => a.mapped - b.mapped);

    return mapped.map(item => arr[item.index]);
}