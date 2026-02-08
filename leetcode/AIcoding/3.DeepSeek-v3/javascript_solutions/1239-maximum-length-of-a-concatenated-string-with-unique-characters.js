var maxLength = function(arr) {
    let maxLen = 0;

    const backtrack = (index, currentStr) => {
        const currentSet = new Set(currentStr);
        if (currentStr.length !== currentSet.size) {
            return;
        }

        maxLen = Math.max(maxLen, currentStr.length);

        for (let i = index; i < arr.length; i++) {
            backtrack(i + 1, currentStr + arr[i]);
        }
    };

    backtrack(0, '');
    return maxLen;
};