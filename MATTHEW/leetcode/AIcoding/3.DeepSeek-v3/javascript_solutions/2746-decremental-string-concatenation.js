var minimizeConcatenatedLength = function(words) {
    const n = words.length;
    const memo = new Map();

    function dfs(index, firstChar, lastChar) {
        if (index === n) {
            return 0;
        }
        const key = `${index},${firstChar},${lastChar}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        const currentWord = words[index];
        const currentFirst = currentWord[0];
        const currentLast = currentWord[currentWord.length - 1];

        // Option 1: append currentWord to the left
        const leftOption = (lastChar === currentFirst ? -1 : 0) + 
                           dfs(index + 1, currentFirst, lastChar);

        // Option 2: append currentWord to the right
        const rightOption = (firstChar === currentLast ? -1 : 0) + 
                            dfs(index + 1, firstChar, currentLast);

        const res = currentWord.length + Math.min(leftOption, rightOption);
        memo.set(key, res);
        return res;
    }

    if (n === 0) return 0;
    const initialWord = words[0];
    return initialWord.length + dfs(1, initialWord[0], initialWord[initialWord.length - 1]);
};