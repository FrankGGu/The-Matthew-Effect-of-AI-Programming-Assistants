var reverseStr = function(s, k) {
    const arr = s.split('');
    for (let i = 0; i < arr.length; i += 2 * k) {
        let start = i;
        let end = Math.min(i + k - 1, arr.length - 1);
        while (start < end) {
            [arr[start], arr[end]] = [arr[end], arr[start]];
            start++;
            end--;
        }
    }
    return arr.join('');
};