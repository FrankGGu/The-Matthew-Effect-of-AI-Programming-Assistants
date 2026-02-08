var repeatLimitedString = function(s, repeatLimit) {
    const counts = new Array(26).fill(0);
    for (let char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = "";
    let i = 25;
    let j = 24;

    while (i >= 0 && j >= 0) {
        if (counts[i] === 0) {
            i--;
            continue;
        }

        if (counts[j] === 0) {
            j--;
            continue;
        }

        let count = Math.min(repeatLimit, counts[i]);
        for (let k = 0; k < count; k++) {
            result += String.fromCharCode(i + 'a'.charCodeAt(0));
        }
        counts[i] -= count;

        if (counts[i] === 0) {
            i--;
            continue;
        }

        if (i === j) {
            j--;
        }

        if (counts[j] === 0) {
            break;
        }

        result += String.fromCharCode(j + 'a'.charCodeAt(0));
        counts[j]--;

    }

    while (i >= 0 && counts[i] > 0) {
       let count = Math.min(repeatLimit, counts[i]);
        for (let k = 0; k < count; k++) {
            result += String.fromCharCode(i + 'a'.charCodeAt(0));
        }
        counts[i] -= count;
        i--;
    }

    return result;
};