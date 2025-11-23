function numSpecialFlowers(target) {
    let calls = 0;
    let count = 0;
    for (let i = 0; i < target.length; i++) {
        let t = target[i];
        while (t > 0) {
            if (t % 2 === 1) {
                calls += 1;
            }
            t = Math.floor(t / 2);
        }
    }
    return calls;
}