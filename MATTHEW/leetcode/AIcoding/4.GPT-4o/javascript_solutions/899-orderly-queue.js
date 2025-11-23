function orderlyQueue(s, k) {
    if (k === 1) {
        let min = s;
        for (let i = 0; i < s.length; i++) {
            const rotated = s.slice(i) + s.slice(0, i);
            if (rotated < min) {
                min = rotated;
            }
        }
        return min;
    } else {
        return s.split('').sort().join('');
    }
}