function minTimeToType(a) {
    let time = 0;
    let prev = 0;
    for (let i = 0; i < a.length; i++) {
        const curr = a[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const diff = Math.abs(curr - prev);
        time += Math.min(diff, 26 - diff);
        prev = curr;
    }
    return time;
}