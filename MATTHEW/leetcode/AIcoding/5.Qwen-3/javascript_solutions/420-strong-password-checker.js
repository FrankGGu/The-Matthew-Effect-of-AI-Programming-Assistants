function strongPasswordChecker(password) {
    let n = password.length;
    let hasLower = false, hasUpper = false, hasDigit = false;
    for (let c of password) {
        if (c >= 'a' && c <= 'z') hasLower = true;
        else if (c >= 'A' && c <= 'Z') hasUpper = true;
        else if (c >= '0' && c <= '9') hasDigit = true;
    }
    let missing = 3 - (hasLower + hasUpper + hasDigit);

    if (n < 6) {
        return Math.max(missing, 6 - n);
    }

    let res = 0;
    let replace = 0;
    let one = 0, two = 0;
    let i = 0;
    while (i < n) {
        let j = i;
        while (j < n && password[j] === password[i]) j++;
        let cnt = j - i;
        if (cnt >= 3) {
            replace += Math.floor(cnt / 3);
            if (cnt % 3 === 0) one++;
            else if (cnt % 3 === 1) two++;
        }
        i = j;
    }

    if (n <= 20) {
        return Math.max(missing, replace);
    }

    let remove = n - 20;
    let useOne = Math.min(one, remove);
    remove -= useOne;
    replace -= useOne;

    if (remove > 0) {
        let useTwo = Math.min(two, remove);
        remove -= useTwo;
        replace -= useTwo;
    }

    if (remove > 0) {
        replace -= Math.floor(remove / 3);
    }

    res = (n - 20) + Math.max(missing, replace);
    return res;
}