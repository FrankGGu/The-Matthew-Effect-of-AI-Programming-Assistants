var numSplits = function(s) {
    let leftCount = new Array(s.length).fill(0);
    let rightCount = new Array(s.length).fill(0);

    let leftSet = new Set();
    let rightSet = new Set();

    for (let i = 0; i < s.length; i++) {
        leftSet.add(s[i]);
        leftCount[i] = leftSet.size;
    }

    for (let i = s.length - 1; i >= 0; i--) {
        rightSet.add(s[i]);
        rightCount[i] = rightSet.size;
    }

    let goodWays = 0;
    for (let i = 0; i < s.length - 1; i++) {
        if (leftCount[i] === rightCount[i + 1]) {
            goodWays++;
        }
    }

    return goodWays;
};