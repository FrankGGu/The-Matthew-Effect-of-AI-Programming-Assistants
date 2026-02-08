var kSimilarity = function(A, B) {
    if (A === B) {
        return 0;
    }

    const n = A.length;
    const queue = [[A, 0]];
    const visited = new Set();
    visited.add(A);

    let head = 0;
    while (head < queue.length) {
        const [currentString, swaps] = queue[head++];

        if (currentString === B) {
            return swaps;
        }

        let i = 0;
        while (i < n && currentString[i] === B[i]) {
            i++;
        }

        for (let j = i + 1; j < n; j++) {
            if (currentString[j] === B[i] && currentString[j] !== B[j]) { // Optimization: currentString[j] !== B[j] avoids swapping an already correct character
                                                                           // currentString[j] == B[i] means we found the character needed at position i
                const charArray = currentString.split('');
                [charArray[i], charArray[j]] = [charArray[j], charArray[i]];
                const nextString = charArray.join('');

                if (!visited.has(nextString)) {
                    visited.add(nextString);
                    queue.push([nextString, swaps + 1]);
                }
            }
        }
    }
    return -1; // Should not be reached if A and B are K-similar
};