function uniqueMiddleModeSubsequences(arr) {
    const count = {};
    arr.forEach(num => {
        count[num] = (count[num] || 0) + 1;
    });

    const uniqueModes = Object.keys(count).filter(num => count[num] === 1).map(Number);
    const subsequences = [];

    function backtrack(start, current) {
        if (current.length > 0) {
            subsequences.push([...current]);
        }
        for (let i = start; i < uniqueModes.length; i++) {
            current.push(uniqueModes[i]);
            backtrack(i + 1, current);
            current.pop();
        }
    }

    backtrack(0, []);
    return subsequences;
}