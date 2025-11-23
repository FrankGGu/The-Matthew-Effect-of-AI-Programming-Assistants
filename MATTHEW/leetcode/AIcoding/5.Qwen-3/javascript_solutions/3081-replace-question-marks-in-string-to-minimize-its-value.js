function minimizeStringValue(s) {
    const n = s.length;
    const arr = s.split('');
    const count = Array(26).fill(0);

    for (let i = 0; i < n; i++) {
        if (arr[i] !== '?') {
            count[arr[i].charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
    }

    const temp = [];
    for (let i = 0; i < n; i++) {
        if (arr[i] === '?') {
            temp.push(i);
        }
    }

    const freq = Array(26).fill(0);
    for (let i = 0; i < 26; i++) {
        freq[i] = count[i];
    }

    for (let i = 0; i < temp.length; i++) {
        let min = 0;
        for (let j = 1; j < 26; j++) {
            if (freq[j] < freq[min]) {
                min = j;
            }
        }
        arr[temp[i]] = String.fromCharCode(min + 'a'.charCodeAt(0));
        freq[min]++;
    }

    return arr.join('');
}