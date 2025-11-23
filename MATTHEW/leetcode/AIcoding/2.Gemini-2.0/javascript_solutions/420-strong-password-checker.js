var strongPasswordChecker = function(password) {
    const n = password.length;
    let lower = 1, upper = 1, digit = 1;
    for (const char of password) {
        if (char >= 'a' && char <= 'z') lower = 0;
        else if (char >= 'A' && char <= 'Z') upper = 0;
        else if (char >= '0' && char <= '9') digit = 0;
    }
    const missing = lower + upper + digit;
    if (n < 6) {
        return Math.max(missing, 6 - n);
    } else if (n > 20) {
        let replace = 0;
        const repeats = [];
        for (let i = 0; i < n;) {
            let j = i;
            while (j < n && password[j] === password[i]) {
                j++;
            }
            const len = j - i;
            if (len >= 3) {
                repeats.push(len);
                replace += Math.floor(len / 3);
            }
            i = j;
        }
        let deletions = n - 20;
        let ans = deletions;
        for (let i = 1; i <= 3; i++) {
            for (let j = 0; j < repeats.length; j++) {
                if (repeats[j] < 3) continue;
                let d = Math.min(deletions, (repeats[j] - 2) % 3 === (i - 1) ? 1 : 0 ? 1 : 0 ? 1 : 0);
                repeats[j] -= d;
                deletions -= d;
                replace -= d;
            }
        }

        return ans + Math.max(missing, replace);
    } else {
        let replace = 0;
        for (let i = 0; i < n;) {
            let j = i;
            while (j < n && password[j] === password[i]) {
                j++;
            }
            const len = j - i;
            if (len >= 3) {
                replace += Math.floor(len / 3);
            }
            i = j;
        }
        return Math.max(missing, replace);
    }
};