var generateBinaryStrings = function(n) {
    const results = [];
    const currentStringArray = new Array(n);

    function backtrack(index) {
        if (index === n) {
            results.push(currentStringArray.join(''));
            return;
        }

        // Option 1: Place '1' at the current position
        currentStringArray[index] = '1';
        backtrack(index + 1);

        // Option 2: Place '0' at the current position
        // This is only allowed if it's the first character (index === 0)
        // or if the previous character was '1' (currentStringArray[index - 1] === '1')
        if (index === 0 || currentStringArray[index - 1] === '1') {
            currentStringArray[index] = '0';
            backtrack(index + 1);
        }
    }

    if (n === 0) {
        return [""];
    }

    backtrack(0);
    return results;
};