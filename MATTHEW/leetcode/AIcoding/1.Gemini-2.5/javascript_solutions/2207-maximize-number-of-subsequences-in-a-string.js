var maximizeNumberofSubsequences = function(text, pattern) {
    let count0SoFar = 0;
    let originalSubsequences = 0;

    let totalCount0 = 0;
    let totalCount1 = 0;

    for (let i = 0; i < text.length; i++) {
        if (text[i] === pattern[1]) {
            originalSubsequences += count0SoFar;
            totalCount1++;
        }
        if (text[i] === pattern[0]) {
            count0SoFar++;
            totalCount0++;
        }
    }

    let resultAddingP0 = originalSubsequences + totalCount1;
    let resultAddingP1 = originalSubsequences + totalCount0;

    return Math.max(resultAddingP0, resultAddingP1);
};