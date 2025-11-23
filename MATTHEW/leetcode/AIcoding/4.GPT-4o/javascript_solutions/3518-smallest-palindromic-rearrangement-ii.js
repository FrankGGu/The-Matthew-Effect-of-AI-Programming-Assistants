function makeSmallestPalindromic(num) {
    const counts = new Array(10).fill(0);
    for (let digit of num) {
        counts[digit]++;
    }

    let left = '';
    let middle = '';
    for (let i = 0; i < 10; i++) {
        if (counts[i] % 2 === 1) {
            if (middle === '' || i < middle) {
                if (middle !== '') {
                    counts[middle]--;
                }
                middle = i;
            } else {
                counts[i]--;
            }
        }
        left += String(i).repeat(Math.floor(counts[i] / 2));
    }

    if (left === '' && middle === '') {
        return '0';
    }

    let right = left.split('').reverse().join('');
    if (middle !== '') {
        return left + middle + right;
    }
    return left + right;
}