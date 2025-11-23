var findLexSmallestString = function(s, a, b) {
    const n = s.length;
    let minStr = s;
    const visited = new Set();

    const rotate = (str, k) => {
        k = k % n;
        return str.substring(n - k) + str.substring(0, n - k);
    };

    const add = (str, k) => {
        let newStr = "";
        for (let i = 0; i < n; i++) {
            let digit = parseInt(str[i]);
            if (i % 2 !== 0) {
                digit = (digit + k) % 10;
            }
            newStr += digit;
        }
        return newStr;
    };

    const queue = [s];
    visited.add(s);

    while (queue.length > 0) {
        const curr = queue.shift();
        if (curr < minStr) {
            minStr = curr;
        }

        const rotated = rotate(curr, b);
        if (!visited.has(rotated)) {
            visited.add(rotated);
            queue.push(rotated);
        }

        const added = add(curr, a);
        if (!visited.has(added)) {
            visited.add(added);
            queue.push(added);
        }
    }

    return minStr;
};