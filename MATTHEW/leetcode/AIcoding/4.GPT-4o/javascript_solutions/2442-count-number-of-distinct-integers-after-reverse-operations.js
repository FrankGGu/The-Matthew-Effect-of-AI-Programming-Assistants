var countDistinctIntegers = function(num) {
    const distinct = new Set();
    const reverseNum = (n) => parseInt(n.toString().split('').reverse().join(''), 10);

    let current = num;
    distinct.add(current);
    distinct.add(reverseNum(current));

    while (current > 0) {
        current = Math.floor(current / 10);
        distinct.add(current);
        distinct.add(reverseNum(current));
    }

    return distinct.size;
};