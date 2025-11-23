function lexSmallestBeautifulString(s) {
    const n = s.length;
    const arr = s.split('');

    function isBeautiful() {
        for (let i = 0; i < n - 1; i++) {
            if (arr[i] === arr[i + 1]) return false;
        }
        for (let i = 0; i < n - 2; i++) {
            if (arr[i] === arr[i + 2]) return false;
        }
        return true;
    }

    function backtrack(pos) {
        if (pos === n) {
            return arr.join('');
        }

        const prev1 = pos > 0 ? arr[pos - 1] : '';
        const prev2 = pos > 1 ? arr[pos - 2] : '';

        for (let c = 0; c < 26; c++) {
            const ch = String.fromCharCode(97 + c);
            if (ch !== prev1 && ch !== prev2) {
                arr[pos] = ch;
                const res = backtrack(pos + 1);
                if (res) return res;
            }
        }

        return null;
    }

    return backtrack(0);
}