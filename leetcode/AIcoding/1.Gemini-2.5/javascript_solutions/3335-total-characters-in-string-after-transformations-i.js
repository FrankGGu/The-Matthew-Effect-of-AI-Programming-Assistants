var getLucky = function(s, k) {
    let numStr = "";
    for (let i = 0; i < s.length; i++) {
        numStr += (s.charCodeAt(i) - 'a'.charCodeAt(0) + 1).toString();
    }

    for (let i = 0; i < k; i++) {
        let currentSum = 0;
        for (let j = 0; j < numStr.length; j++) {
            currentSum += parseInt(numStr[j]);
        }
        numStr = currentSum.toString();
    }

    return parseInt(numStr);
};