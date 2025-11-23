var findTheDifference = function(s, t) {
    let sSum = 0;
    let tSum = 0;

    for (let i = 0; i < s.length; i++) {
        sSum += s.charCodeAt(i);
    }

    for (let i = 0; i < t.length; i++) {
        tSum += t.charCodeAt(i);
    }

    return String.fromCharCode(tSum - sSum);
};