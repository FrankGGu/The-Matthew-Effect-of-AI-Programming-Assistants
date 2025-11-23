var executeInstructions = function(n, startPos, s) {
    const result = new Array(s.length).fill(0);

    for (let i = 0; i < s.length; i++) {
        let currentRow = startPos[0];
        let currentCol = startPos[1];
        let count = 0;

        for (let j = i; j < s.length; j++) {
            const instruction = s[j];

            if (instruction === 'L') {
                currentCol--;
            } else if (instruction === 'R') {
                currentCol++;
            } else if (instruction === 'U') {
                currentRow--;
            } else if (instruction === 'D') {
                currentRow++;
            }

            if (currentRow < 0 || currentRow >= n || currentCol < 0 || currentCol >= n) {
                break;
            }

            count++;
        }
        result[i] = count;
    }

    return result;
};