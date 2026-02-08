var checkStrings = function(s) {
    for (let i = 0; i < s.length - 1; i++) {
        const sub = s.substring(i, i + 2);
        const reversedSub = sub[1] + sub[0];

        if (sub[0] === sub[1]) {
            return true;
        }

        if (s.includes(reversedSub)) {
            return true;
        }
    }

    return false;
};