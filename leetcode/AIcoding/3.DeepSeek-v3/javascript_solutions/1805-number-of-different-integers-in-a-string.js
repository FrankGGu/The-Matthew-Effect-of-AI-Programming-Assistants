var numDifferentIntegers = function(word) {
    const nums = new Set();
    let currentNum = '';

    for (const char of word) {
        if (/\d/.test(char)) {
            currentNum += char;
        } else if (currentNum !== '') {
            nums.add(BigInt(currentNum));
            currentNum = '';
        }
    }

    if (currentNum !== '') {
        nums.add(BigInt(currentNum));
    }

    return nums.size;
};