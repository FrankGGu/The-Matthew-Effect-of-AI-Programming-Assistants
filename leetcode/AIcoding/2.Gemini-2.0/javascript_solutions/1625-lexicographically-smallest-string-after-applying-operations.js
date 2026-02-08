var findLexSmallestString = function(s, a, b) {
    let n = s.length;
    let visited = new Set();
    let q = [s];
    let smallest = s;

    while (q.length > 0) {
        let curr = q.shift();

        if (visited.has(curr)) continue;
        visited.add(curr);

        smallest = smallest < curr ? smallest : curr;

        let addResult = "";
        for (let i = 0; i < n; i++) {
            let digit = parseInt(curr[i]);
            if (i % 2 === 1) {
                digit = (digit + a) % 10;
            }
            addResult += digit;
        }

        let rotateResult = "";
        for (let i = 0; i < n; i++) {
            rotateResult += addResult[(i - b + n) % n];
        }

        q.push(addResult);
        q.push(rotateResult);
    }

    return smallest;
};