var findKthBit = function(n, k) {
    const getString = (n) => {
        if (n === 1) return '0';
        const prev = getString(n - 1);
        return prev + '1' + reverseInvert(prev);
    };

    const reverseInvert = (s) => {
        return s.split('').reverse().map(bit => bit === '0' ? '1' : '0').join('');
    };

    const binaryString = getString(n);
    return binaryString[k - 1];
};