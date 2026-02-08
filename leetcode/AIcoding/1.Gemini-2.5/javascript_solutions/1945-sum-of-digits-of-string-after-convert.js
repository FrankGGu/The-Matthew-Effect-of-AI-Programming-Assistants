var getLucky = function(s, k) {
    let digitString = "";
    for (let i = 0; i < s.length; i++) {
        digitString += (s.charCodeAt(i) - 'a'.charCodeAt(0) + 1).toString();
    }

    let currentSum = 0;
    for (let i = 0; i < k; i++) {
        currentSum = 0;
        for (let j = 0; j < digitString.length; j++) {
            currentSum += parseInt(digitString[j]);
        }
        digitString = currentSum.toString();
    }

    return currentSum;
};