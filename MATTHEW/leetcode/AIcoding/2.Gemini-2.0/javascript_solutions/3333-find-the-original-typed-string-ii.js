var isLongPressedName = function(s, t) {
    let i = 0;
    let j = 0;
    while (j < t.length) {
        if (i < s.length && s[i] === t[j]) {
            i++;
            j++;
        } else if (j > 0 && t[j] === t[j - 1]) {
            j++;
        } else {
            return false;
        }
    }
    return i === s.length;
};

var isPossible = function(s, t) {
    if (s.length > t.length) return false;
    return isLongPressedName(s, t);
};

var findOriginalString = function(s, t) {
    let sArr = s.split("");
    let tArr = t.split("");
    sArr.sort();
    tArr.sort();
    if (sArr.join("") !== tArr.join("")) return "";

    let dp = new Array(s.length + 1).fill(null).map(() => new Array(t.length + 1).fill(false));
    dp[0][0] = true;

    for (let i = 0; i <= s.length; i++) {
        for (let j = 0; j <= t.length; j++) {
            if (!dp[i][j]) continue;

            if (i < s.length && j < t.length && s[i] === t[j]) {
                let tempS = s.substring(0, i) + s.substring(i + 1);
                let tempT = t.substring(0, j) + t.substring(j + 1);
                if (isPossible(tempS, tempT)) {
                    dp[i + 1][j + 1] = true;
                }
            }
        }
    }

    let result = "";
    let i = 0;
    let j = 0;
    while (i < s.length && j < t.length) {
        let tempS = s.substring(0, i) + s.substring(i + 1);
        let tempT = t.substring(0, j) + t.substring(j + 1);
        if (s[i] === t[j] && isPossible(tempS, tempT)) {
            result += s[i];
            i++;
            j++;
        } else {
            i++;
        }
    }

    return result;
};