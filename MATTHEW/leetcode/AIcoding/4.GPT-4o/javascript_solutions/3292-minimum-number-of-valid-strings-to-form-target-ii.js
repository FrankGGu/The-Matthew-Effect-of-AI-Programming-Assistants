function minNumberOfValidStrings(target, strings) {
    const count = new Array(26).fill(0);
    for (const char of target) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const dp = new Array(target.length + 1).fill(Infinity);
    dp[0] = 0;

    for (const str of strings) {
        const tempCount = new Array(26).fill(0);
        for (const char of str) {
            tempCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        for (let j = target.length; j >= 0; j--) {
            let canForm = true;
            for (let k = 0; k < 26; k++) {
                if (count[k] > 0 && tempCount[k] < count[k]) {
                    canForm = false;
                    break;
                }
            }
            if (canForm) {
                dp[j + str.length] = Math.min(dp[j + str.length], dp[j] + 1);
            }
        }
    }

    return dp[target.length] === Infinity ? -1 : dp[target.length];
}