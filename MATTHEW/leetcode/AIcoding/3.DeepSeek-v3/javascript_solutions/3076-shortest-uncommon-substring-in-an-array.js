var shortestUncommonSubstring = function(arr) {
    const n = arr.length;
    const map = new Map();

    for (let i = 0; i < n; i++) {
        const s = arr[i];
        const substrings = new Set();
        for (let j = 0; j < s.length; j++) {
            for (let k = j + 1; k <= s.length; k++) {
                const substr = s.substring(j, k);
                substrings.add(substr);
            }
        }
        for (const substr of substrings) {
            if (!map.has(substr)) {
                map.set(substr, new Set());
            }
            map.get(substr).add(i);
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const s = arr[i];
        let shortest = "";
        for (let j = 0; j < s.length; j++) {
            for (let k = j + 1; k <= s.length; k++) {
                const substr = s.substring(j, k);
                if (map.get(substr).size === 1) {
                    if (shortest === "" || substr.length < shortest.length || (substr.length === shortest.length && substr < shortest)) {
                        shortest = substr;
                    }
                }
            }
        }
        result.push(shortest === "" ? "" : shortest);
    }

    return result;
};