var alphabetBoardPath = function(target) {
    const getCoords = (char) => {
        if (char === 'z') {
            return [5, 0];
        }
        const charCode = char.charCodeAt(0) - 'a'.charCodeAt(0);
        const r = Math.floor(charCode / 5);
        const c = charCode % 5;
        return [r, c];
    };

    let currentR = 0;
    let currentC = 0;
    const path = [];

    for (const char of target) {
        const [targetR, targetC] = getCoords(char);

        const dr = targetR - currentR;
        const dc = targetC - currentC;

        // Special handling for 'z' to avoid moving off board
        // If current position is 'z' (row 5) and target is not 'z', must move Up first
        if (currentR === 5 && dr < 0) { 
            for (let i = 0; i < Math.abs(dr); i++) {
                path.push('U');
            }
            for (let i = 0; i < Math.abs(dc); i++) {
                path.push(dc < 0 ? 'L' : 'R');
            }
        } 
        // If target position is 'z' (row 5) and current is not 'z', must move Left first
        else if (targetR === 5 && dr > 0) { 
            for (let i = 0; i < Math.abs(dc); i++) {
                path.push(dc < 0 ? 'L' : 'R');
            }
            for (let i = 0; i < Math.abs(dr); i++) {
                path.push('D');
            }
        }
        // General case: vertical then horizontal
        else {
            for (let i = 0; i < Math.abs(dr); i++) {
                path.push(dr < 0 ? 'U' : 'D');
            }
            for (let i = 0; i < Math.abs(dc); i++) {
                path.push(dc < 0 ? 'L' : 'R');
            }
        }

        path.push('!');
        currentR = targetR;
        currentC = targetC;
    }

    return path.join('');
};