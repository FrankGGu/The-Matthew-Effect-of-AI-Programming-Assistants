var separateNumbers = function(s) {
    const n = s.length;

    for (let len = 1; len <= n / 2; len++) {
        let firstNum = s.slice(0, len);
        let currentNum = BigInt(firstNum);
        let currentStr = firstNum;

        while (currentStr.length < n) {
            currentNum++;
            currentStr += currentNum.toString();
        }

        if (currentStr === s) {
            return `YES ${firstNum}`;
        }
    }

    return "NO";
};