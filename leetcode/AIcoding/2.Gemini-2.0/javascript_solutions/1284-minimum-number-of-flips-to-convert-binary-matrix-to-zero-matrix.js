var minFlips = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    const initialState = mat.map(row => row.join('')).join('');

    const targetState = Array(m).fill(Array(n).fill('0').join('')).join('');

    if (initialState === targetState) return 0;

    const queue = [[initialState, 0]];
    const visited = new Set([initialState]);

    const neighbors = (state) => {
        const nextStates = [];
        const tempMat = [];
        let index = 0;
        for (let i = 0; i < m; i++) {
            tempMat.push([]);
            for (let j = 0; j < n; j++) {
                tempMat[i].push(state[index]);
                index++;
            }
        }

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                const newMat = tempMat.map(row => [...row]);
                newMat[i][j] = newMat[i][j] === '0' ? '1' : '0';
                if (i > 0) newMat[i - 1][j] = newMat[i - 1][j] === '0' ? '1' : '0';
                if (i < m - 1) newMat[i + 1][j] = newMat[i + 1][j] === '0' ? '1' : '0';
                if (j > 0) newMat[i][j - 1] = newMat[i][j - 1] === '0' ? '1' : '0';
                if (j < n - 1) newMat[i][j + 1] = newMat[i][j + 1] === '0' ? '1' : '0';

                const newState = newMat.map(row => row.join('')).join('');
                nextStates.push(newState);
            }
        }
        return nextStates;
    };

    while (queue.length > 0) {
        const [currentState, steps] = queue.shift();

        const nextStates = neighbors(currentState);

        for (const nextState of nextStates) {
            if (nextState === targetState) {
                return steps + 1;
            }

            if (!visited.has(nextState)) {
                visited.add(nextState);
                queue.push([nextState, steps + 1]);
            }
        }
    }

    return -1;
};