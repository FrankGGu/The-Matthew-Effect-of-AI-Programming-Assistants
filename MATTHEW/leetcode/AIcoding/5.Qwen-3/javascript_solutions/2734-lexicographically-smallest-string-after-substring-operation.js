function lexSmallestString(s, target) {
    const n = s.length;
    const arr = s.split('');

    for (let i = 0; i < n; i++) {
        if (arr[i] === target[i]) continue;

        let j = i;
        while (j < n && arr[j] === target[j]) j++;

        if (j === n) break;

        const diff = (target[i].charCodeAt(0) - arr[i].charCodeAt(0) + 26) % 26;
        for (let k = i; k < j; k++) {
            arr[k] = String.fromCharCode((arr[k].charCodeAt(0) + diff) % 26 + 97);
        }

        break;
    }

    return arr.join('');
}