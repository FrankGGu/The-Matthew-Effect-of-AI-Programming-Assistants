var maxLength = function(arr) {
    let maxLen = 0;

    const backtrack = (index, current) => {
        if (new Set(current).size !== current.length) return; 
        maxLen = Math.max(maxLen, current.length);

        for (let i = index; i < arr.length; i++) {
            backtrack(i + 1, current + arr[i]);
        }
    };

    backtrack(0, "");
    return maxLen;
};