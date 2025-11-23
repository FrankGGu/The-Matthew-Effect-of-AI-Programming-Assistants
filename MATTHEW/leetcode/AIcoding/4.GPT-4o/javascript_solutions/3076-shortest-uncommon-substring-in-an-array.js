function shortestUncommonSubstring(A) {
    const n = A.length;
    let minLength = Infinity;
    let result = "";

    function isSubstrUncommon(substr) {
        return A.every(a => !a.includes(substr));
    }

    for (let len = 1; len <= 10; len++) {
        for (let i = 0; i <= 26 ** len - 1; i++) {
            let substr = "";
            let temp = i;
            for (let j = 0; j < len; j++) {
                substr += String.fromCharCode((temp % 26) + 97);
                temp = Math.floor(temp / 26);
            }
            if (isSubstrUncommon(substr) && substr.length < minLength) {
                minLength = substr.length;
                result = substr;
            }
        }
    }

    return result;
}