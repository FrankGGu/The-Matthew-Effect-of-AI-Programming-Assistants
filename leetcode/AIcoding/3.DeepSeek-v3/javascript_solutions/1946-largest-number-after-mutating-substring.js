var maximumNumber = function(num, change) {
    const numStr = num.toString();
    let mutated = false;
    let result = [];

    for (let i = 0; i < numStr.length; i++) {
        const digit = parseInt(numStr[i]);
        const newDigit = change[digit];

        if (newDigit > digit) {
            result.push(newDigit.toString());
            mutated = true;
            for (let j = i + 1; j < numStr.length; j++) {
                const nextDigit = parseInt(numStr[j]);
                const nextNewDigit = change[nextDigit];
                if (nextNewDigit >= nextDigit) {
                    result.push(nextNewDigit.toString());
                } else {
                    i = j - 1;
                    break;
                }
                if (j === numStr.length - 1) {
                    i = j;
                }
            }
        } else if (newDigit === digit) {
            result.push(digit.toString());
        } else {
            if (mutated) {
                result.push(numStr.substring(i));
                break;
            } else {
                result.push(digit.toString());
            }
        }
    }

    return parseInt(result.join(''));
};