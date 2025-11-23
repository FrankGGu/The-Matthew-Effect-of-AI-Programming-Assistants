var getMaxGridHappiness = function(m, n, introvertsCount, extrovertsCount) {
    const dp = new Map();

    function solve(row, col, introverts, extroverts, prev) {
        if (row === m) {
            return 0;
        }

        const key = `${row}-${col}-${introverts}-${extroverts}-${prev}`;
        if (dp.has(key)) {
            return dp.get(key);
        }

        const nextRow = col === n - 1 ? row + 1 : row;
        const nextCol = col === n - 1 ? 0 : col + 1;

        let ans = solve(nextRow, nextCol, introverts, extroverts, 0);

        if (introverts > 0) {
            let score = 120;
            if (col > 0 && prev === 1) {
                score -= 30;
            }
            if (row > 0 && dp.has(`${row - 1}-${col}-${introverts + 1}-${extroverts}-${prev}`) && dp.get(`${row - 1}-${col}-${introverts + 1}-${extroverts}-${prev}`) !== undefined) {
                 score -= 30;
            } else if (row > 0 && dp.has(`${row - 1}-${col}-${introverts}-${extroverts}-${1}`) && dp.get(`${row - 1}-${col}-${introverts}-${extroverts}-${1}`) !== undefined) {
                score -= 30;
            } else if (row > 0 && prev === 1) {
                 score -= 30;
            }

            ans = Math.max(ans, score + solve(nextRow, nextCol, introverts - 1, extroverts, 1));
        }

        if (extroverts > 0) {
            let score = 40;
            if (col > 0 && prev === 2) {
                score += 20;
            }
             if (row > 0 && dp.has(`${row - 1}-${col}-${introverts}-${extroverts+1}-${prev}`) && dp.get(`${row - 1}-${col}-${introverts}-${extroverts+1}-${prev}`) !== undefined) {
                score += 20;
            }
            else if (row > 0 && dp.has(`${row - 1}-${col}-${introverts}-${extroverts}-${2}`) && dp.get(`${row - 1}-${col}-${introverts}-${extroverts}-${2}`) !== undefined){
                score += 20;
            }
            else if (row > 0 && prev === 2) {
                score += 20;
            }
            ans = Math.max(ans, score + solve(nextRow, nextCol, introverts, extroverts - 1, 2));
        }

        dp.set(key, ans);
        return ans;
    }

    return solve(0, 0, introvertsCount, extrovertsCount, 0);
};