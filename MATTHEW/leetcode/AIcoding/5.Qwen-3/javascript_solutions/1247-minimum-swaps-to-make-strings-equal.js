function minSwap(s1, s2) {
    let x = 0, y = 0;
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            if (s1[i] === 'x') x++;
            else y++;
        }
    }
    return (x + 1 >> 1) + (y + 1 >> 1);
}