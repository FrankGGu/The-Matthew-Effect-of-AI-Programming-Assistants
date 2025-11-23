var repeatLimitedString = function(s, repeatLimit) {
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = "";
    let i = 25;
    let j = 24;

    while (i >= 0 && j >= 0) {
        if (counts[i] === 0) {
            i--;
        } else if (counts[j] === 0) {
            j--;
        } else {
            if (counts[i] <= repeatLimit) {
                result += String.fromCharCode(i + 'a'.charCodeAt(0)).repeat(counts[i]);
                counts[j] -= 0;
                counts[i] = 0;
                i--;
            } else {
                result += String.fromCharCode(i + 'a'.charCodeAt(0)).repeat(repeatLimit);
                counts[i] -= repeatLimit;
                if (counts[j] > 0) {
                    result += String.fromCharCode(j + 'a'.charCodeAt(0));
                    counts[j]--;
                } else {
                    j--;
                    continue;
                }
            }
        }

    }
    while(i >= 0 && counts[i] > 0){
        if (counts[i] <= repeatLimit) {
            result += String.fromCharCode(i + 'a'.charCodeAt(0)).repeat(counts[i]);
            counts[i] = 0;
            i--;
        }
        else{
             result += String.fromCharCode(i + 'a'.charCodeAt(0)).repeat(repeatLimit);
             counts[i] -= repeatLimit;
        }
    }
    return result;
};