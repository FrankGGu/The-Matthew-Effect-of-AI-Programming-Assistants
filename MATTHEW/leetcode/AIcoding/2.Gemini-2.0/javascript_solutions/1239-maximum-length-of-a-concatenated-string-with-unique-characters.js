var maxLength = function(arr) {
    let maxLen = 0;

    function isUnique(str) {
        const charSet = new Set();
        for (let char of str) {
            if (charSet.has(char)) {
                return false;
            }
            charSet.add(char);
        }
        return true;
    }

    function backtrack(index, currentStr) {
        if (!isUnique(currentStr)) {
            return;
        }

        maxLen = Math.max(maxLen, currentStr.length);

        for (let i = index; i < arr.length; i++) {
            backtrack(i + 1, currentStr + arr[i]);
        }
    }

    backtrack(0, "");
    return maxLen;
};