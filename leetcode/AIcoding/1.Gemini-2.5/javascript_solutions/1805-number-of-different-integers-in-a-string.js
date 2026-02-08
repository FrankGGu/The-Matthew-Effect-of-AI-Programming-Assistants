var numDifferentIntegers = function(word) {
    const numbers = new Set();
    let currentNumber = "";

    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        if (char >= '0' && char <= '9') {
            currentNumber += char;
        } else {
            if (currentNumber.length > 0) {
                numbers.add(parseInt(currentNumber).toString());
                currentNumber = "";
            }
        }
    }

    if (currentNumber.length > 0) {
        numbers.add(parseInt(currentNumber).toString());
    }

    return numbers.size;
};