var smallestBeautifulString = function(s, k) {
    const n = s.length;
    const arr = Array.from(s).map(c => c.charCodeAt(0) - 'a'.charCodeAt(0));
    let found = false;

    for (let i = n - 1; i >= 0 && !found; --i) {
        for (let d = arr[i] + 1; d < k; ++d) {
            if ((i >= 1 && d === arr[i - 1]) || (i >= 2 && d === arr[i - 2])) {
                continue;
            }
            arr[i] = d;
            found = true;
            for (let j = i + 1; j < n; ++j) {
                for (let c = 0; c < k; ++c) {
                    if ((j >= 1 && c === arr[j - 1]) || (j >= 2 && c === arr[j - 2])) {
                        continue;
                    }
                    arr[j] = c;
                    break;
                }
            }
            break;
        }
    }

    if (!found) return "";

    return arr.map(c => String.fromCharCode(c + 'a'.charCodeAt(0))).join('');
};