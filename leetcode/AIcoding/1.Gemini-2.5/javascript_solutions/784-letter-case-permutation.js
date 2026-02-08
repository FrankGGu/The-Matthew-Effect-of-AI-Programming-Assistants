var letterCasePermutation = function(s) {
    const result = [];
    const n = s.length;

    function backtrack(index, currentStringArray) {
        if (index === n) {
            result.push(currentStringArray.join(''));
            return;
        }

        const char = s[index];

        if (/[a-zA-Z]/.test(char)) {
            // Option 1: Keep current case
            currentStringArray.push(char);
            backtrack(index + 1, currentStringArray);
            currentStringArray.pop(); // Backtrack

            // Option 2: Change case
            if (char === char.toLowerCase()) {
                currentStringArray.push(char.toUpperCase());
            } else {
                currentStringArray.push(char.toLowerCase());
            }
            backtrack(index + 1, currentStringArray);
            currentStringArray.pop(); // Backtrack
        } else {
            // It's a digit, no case change
            currentStringArray.push(char);
            backtrack(index + 1, currentStringArray);
            currentStringArray.pop(); // Backtrack
        }
    }

    backtrack(0, []);
    return result;
};