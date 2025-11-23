var numMagicSquaresInside = function(grid) {
    let count = 0;

    const isMagicSquare = (subGrid) => {
        const sum = 15;
        const nums = new Set();
        let currentSum = 0;

        for (let i = 0; i < 3; i++) {
            currentSum = 0;
            for (let j = 0; j < 3; j++) {
                currentSum += subGrid[i][j];
                nums.add(subGrid[i][j]);
            }
            if (currentSum !== sum) return false;
        }

        for (let j = 0; j < 3; j++) {
            currentSum = 0;
            for (let i = 0; i < 3; i++) {
                currentSum += subGrid[i][j];
            }
            if (currentSum !== sum) return false;
        }

        currentSum = 0;
        for (let i = 0; i < 3; i++) {
            currentSum += subGrid[i][i];
        }
        if (currentSum !== sum) return false;

        currentSum = 0;
        for (let i = 0; i < 3; i++) {
            currentSum += subGrid[i][2 - i];
        }
        if (currentSum !== sum) return false;

        return nums.size === 9 && !nums.has(0);
    };

    for (let i = 0; i < grid.length - 2; i++) {
        for (let j = 0; j < grid[0].length - 2; j++) {
            const subGrid = [
                [grid[i][j], grid[i][j + 1], grid[i][j + 2]],
                [grid[i + 1][j], grid[i + 1][j + 1], grid[i + 1][j + 2]],
                [grid[i + 2][j], grid[i + 2][j + 1], grid[i + 2][j + 2]]
            ];
            if (isMagicSquare(subGrid)) {
                count++;
            }
        }
    }

    return count;
};